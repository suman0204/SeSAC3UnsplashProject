//
//  RandomPhotoViewController.swift
//  SeSAC3UnsplashProject
//
//  Created by 홍수만 on 2023/09/18.
//

import UIKit
import SnapKit

class RandomPhotoViewController: UIViewController {
    
    let insertCountTextField = {
       let view = UITextField()
        view.backgroundColor = .white
        view.placeholder = "랜덤 사진을 몇 개 받아올까요?"
        return view
    }()
    
    let insertPhotoButton = {
        let view = UIButton()
        view.setTitle("랜덤 이미지 추가", for: .normal)
        view.backgroundColor = .blue
        view.tintColor = .blue
        return view
    }()
    
    let clearButton = {
        let view = UIButton()
        view.setTitle("사진 초기화", for: .normal)
        view.backgroundColor = .red
        view.tintColor = .red
        return view
    }()
    
    let validLabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "숫자"
        view.textAlignment = .center
        return view
    }()
    
    var viewModel = RandomViewModel()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    var dataSource: UICollectionViewDiffableDataSource<Int, RandomPhotoElement>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        setConstraints()
        
        configureDataSoure()
        
        insertCountTextField.addTarget(self, action: #selector(insertedTextFieldChanged), for: .editingChanged)
        
        insertPhotoButton.addTarget(self, action: #selector(insertPhotoButtonClicked), for: .touchUpInside)
        
        viewModel.insertedCount.bind { text in
            self.insertCountTextField.text = text
        }
        
        viewModel.validText.bind { text in
            self.validLabel.text = text
        }
        
        viewModel.randomPhotoList.bind { _ in
            self.updateSnapshot()
        }
        
//        APIService.shared.randomPhoto(count: 3) { randomPhoto in
//            print(randomPhoto)
//        }
    }
    
    @objc func insertedTextFieldChanged() {
        viewModel.insertedCount.value = insertCountTextField.text
        viewModel.checkInseredCountValidation()
        
    }
    
    @objc func insertPhotoButtonClicked() {
        print("clicked")
        viewModel.fetchRandomPhoto(count: Int(insertCountTextField.text!) ?? 0)
    }
    
    static private func layout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .grouped)
        configuration.backgroundColor = .systemMint
        
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
    private func configureDataSoure() {
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewCell, RandomPhotoElement>  { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell()
            
            content.text = "\(itemIdentifier.likes)"
            
            DispatchQueue.global().async {
                let url = URL(string: itemIdentifier.urls.raw)!
                let data = try? Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    content.image = UIImage(data: data!)
                    content.imageProperties.maximumSize = .init(width: 100, height: 100)
                    cell.contentConfiguration = content
                }
            }
            
//            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            
            return cell
        })
        
    }
    
    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, RandomPhotoElement>()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModel.randomPhotoList.value)
        dataSource.apply(snapshot)
    }
    
    private func configureView() {
        [insertCountTextField, clearButton, collectionView, validLabel, insertPhotoButton].forEach {
            view.addSubview($0)
        }
    }
    
    private func setConstraints() {
        insertCountTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
        
        validLabel.snp.makeConstraints { make in
            make.top.equalTo(insertCountTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(30)
        }
        
        clearButton.snp.makeConstraints { make in
            make.top.equalTo(validLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
        
        insertPhotoButton.snp.makeConstraints { make in
            make.top.equalTo(clearButton.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
        
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(insertPhotoButton.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
