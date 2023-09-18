//
//  PhotoViewController.swift
//  SeSAC3UnsplashProject
//
//  Created by 홍수만 on 2023/09/12.
//

import UIKit

class PhotoViewController: UIViewController {
    
//    @IBOutlet var tableView: UITableView!
    @IBOutlet var collectionView: UICollectionView!
    
    var viewModel = PhotoViewModel()
    
    var dataSource: UICollectionViewDiffableDataSource<Int, PhotoResult>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchBar = UISearchBar()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        collectionView.collectionViewLayout = createLayout()
        configureDataSource()
        
//        viewModel.fetchPhoto()
        
        viewModel.list.bind { _ in
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
            self.updateSnapshot()
        }
        
//        tableView.delegate = self
//        tableView.dataSource = self
        
    }
    
    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, PhotoResult>()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModel.list.value.results)
        dataSource.apply(snapshot)
    }
    
    
     private func createLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.showsSeparators = false
        configuration.backgroundColor = .systemGreen
        
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
    private func configureDataSource() {

        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, PhotoResult> { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell()
            content.text = "\(itemIdentifier.likes)"
            
            //URL을 데이터로 바꾸고 데이터를 이미지로 바꿔서 셀에 넣어보기
            DispatchQueue.global().async {
                let url = URL(string: itemIdentifier.urls.thumb)!
                let data = try? Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    content.image = UIImage(data: data!)
                    cell.contentConfiguration = content
                }
            }
            
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            
            return cell
        })
    }
}

extension PhotoViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.fetchPhoto(text: searchBar.text!)
    }
    
}

//extension PhotoViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.rowCount
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell")!
//
//        let data = viewModel.cellForRowAt(at: indexPath)
//
//        cell.backgroundColor = .lightGray
//
//        return cell
//    }
//
//
//}
