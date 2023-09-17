//
//  SimpleColletionViewController.swift
//  SeSAC3UnsplashProject
//
//  Created by 홍수만 on 2023/09/14.
//

import UIKit
import SnapKit

class SimpleColletionViewController: UIViewController {
    
    enum Section: Int, CaseIterable {
        case first = 2000
        case second = 1
    }
    
    let list = [User(name: "Hue", age: 23), User(name: "Hue", age: 23),  User(name: "Jack", age: 21), User(name: "Bran", age: 20 ), User(name: "Kokojong", age: 20)]
    
    let list2 = [User(name: "Jack", age: 23),  User(name: "Jack", age: 21), User(name: "Bran", age: 20 ), User(name: "Kokojong", age: 20)]

    var collectinoView = UICollectionView(frame: .zero, collectionViewLayout: createLayout()) //codebase로 만들때 frame, layout을 먼저 정해줘야함
    
    //collectionView.register
//    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, User>!
    
    var dataSource: UICollectionViewDiffableDataSource<String, User>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectinoView)
//        collectinoView.dataSource = self - Diffable
//        collectinoView.delegate = self - Diffable
        collectinoView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        configureDateSource()
        
        var snapshot = NSDiffableDataSourceSnapshot<String, User>() //스냅샷을 찍을 수 있게 해주는 구조체
        snapshot.appendSections(["고래밥", "Jack"]) //섹션  // Section.allCases = [first, second]
        snapshot.appendItems(list, toSection: "고래밥")  //list를 사용한다 -> list.count를 알게됨
        snapshot.appendItems(list2, toSection: "Jack")
        
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
