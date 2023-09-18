//
//  SimpleColletionViewController.swift
//  SeSAC3UnsplashProject
//
//  Created by 홍수만 on 2023/09/14.
//

import UIKit
import SnapKit

//VM은 별도의 파일로 빼기
class SimpleViewModel {
    
    var list: Observable<[User]> = Observable([ ])
    
    let list2 = [User(name: "Jack", age: 23),  User(name: "Jack", age: 21), User(name: "Bran", age: 20 ), User(name: "Kokojong", age: 20)]


    func append() {
        list.value = [User(name: "Hue", age: 23), User(name: "Hue", age: 23),  User(name: "Jack", age: 21), User(name: "Bran", age: 20 ), User(name: "Kokojong", age: 20)]
    }
    
    func remove() {
        list.value = []
    }
    
    func removeUser(idx: Int) {
        list.value.remove(at: idx)
    }
    
    func insertUser(name: String) {
        let user = User(name: name, age: Int.random(in: 10...70))
        list.value.insert(user, at: Int.random(in: 0...2))
    }
}

class SimpleColletionViewController: UIViewController {
    
    enum Section: Int, CaseIterable {
        case first = 2000
        case second = 1
    }
    
    var viewModel = SimpleViewModel()
 
    var collectinoView = UICollectionView(frame: .zero, collectionViewLayout: createLayout()) //codebase로 만들때 frame, layout을 먼저 정해줘야함
    
    //collectionView.register
//    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, User>!
    
    var dataSource: UICollectionViewDiffableDataSource<String, User>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchBar = UISearchBar()
        searchBar.delegate = self
        navigationItem.titleView = searchBar //titleView에 이미지도 넣을 수 있다
        
        view.addSubview(collectinoView)
//        collectinoView.dataSource = self - Diffable
//        collectinoView.delegate = self - Diffable
        collectinoView.delegate = self
        collectinoView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        configureDateSource() //snapshot 코드 보다 상단에 호출하지 않으면 nil값이 생긴다
        
        updateSnapshot()
        
        viewModel.list.bind { user in
            self.updateSnapshot()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.viewModel.append()
        }
        
    }
    
    func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<String, User>() //스냅샷을 찍을 수 있게 해주는 구조체
        snapshot.appendSections(["고래밥", "Jack"]) //섹션  // Section.allCases = [first, second]
        snapshot.appendItems(viewModel.list.value, toSection: "고래밥")  //list를 사용한다 -> list.count를 알게됨
        snapshot.appendItems(viewModel.list2, toSection: "Jack")
        
        dataSource.apply(snapshot)

    }
    
    // 더 빨리 만들어져야 하기 때문에 static으로 선언
    static private func createLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.showsSeparators = false
        configuration.backgroundColor = .systemGreen
        
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
    private func configureDateSource() {

        //UICollectionView.CellRegistraion: iOS 14 이상 부터 사용 가능한 셀 등록 방법, register 메서들 같은 메서드 대신 제네릭을 사용, 셀이 생성될 때 마다 클로저가 호출
        //밖에 선언되어 있던 cellRegistraton을 함수 안에서 선언해준다
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, User>(handler: { cell, indexPath, itemIdentifier in
            
            //셀 디자인 및 데이터 처리
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.name
            content.textProperties.color = .brown
            content.secondaryText = "\(itemIdentifier.age)"
            content.image = UIImage(systemName: "star.fill")
            content.imageProperties.tintColor = .systemRed
            content.prefersSideBySideTextAndSecondaryText = false
            content.textToSecondaryTextVerticalPadding = 20
            
            cell.contentConfiguration = content
            
            var backgroundConfig = UIBackgroundConfiguration.listPlainCell()
            backgroundConfig.backgroundColor = .lightGray
            backgroundConfig.cornerRadius = 10
            backgroundConfig.strokeWidth = 2
            backgroundConfig.strokeColor = .systemPink
            
            cell.backgroundConfiguration = backgroundConfig
            
        })
    
        //CellForItemAt으로 생각하기
        //dataSource는 snapshot을 활용해야되기 때문에 함수 내부에서 선언하지 않는다
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectinoView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            
            return cell
        })
    }
}

extension SimpleColletionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        let user = viewModel.list.value[indexPath.item] //기존에 사용하던 indexPath기반의 방식 /Diffable에서 이렇게 활용해도 되지만 diffable의 목적에 대해 맞지 않기 때문에 아래의 방법으로 사용하자
        
        guard let user = dataSource.itemIdentifier(for: indexPath) else {
            //값이 없을 때의 대응에 대한 로직을 구현하자
            return
        }
        
        dump(user)
//        viewModel.removeUser(idx: indexPath.item)
    }
}

extension SimpleColletionViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.insertUser(name: searchBar.text!) //매개변수의 옵셔널 처리도 VM에서 처리해준다 (매개변수의 타입을 옵셔널로 받고 함수 내에서 처리)
    }
}

// Diffable
//extension SimpleColletionViewController: UICollectionViewDataSource {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return list.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: list[indexPath.item])
//
//        return cell
//    }
//
//
//}
