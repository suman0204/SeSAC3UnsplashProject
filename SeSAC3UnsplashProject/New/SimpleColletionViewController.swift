//
//  SimpleColletionViewController.swift
//  SeSAC3UnsplashProject
//
//  Created by 홍수만 on 2023/09/14.
//

import UIKit
import SnapKit

class SimpleColletionViewController: UIViewController {
    
    let list = [User(name: "Hue", age: 23), User(name: "Jack", age: 21), User(name: "Bran", age: 20 ), User(name: "Kokojong", age: 20)]

    var collectinoView = UICollectionView(frame: .zero, collectionViewLayout: createLayout()) //codebase로 만들때 frame, layout을 먼저 정해줘야함
    
    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, User>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectinoView)
        collectinoView.dataSource = self
        collectinoView.delegate = self
        collectinoView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        //UICollectionView.CellRegistraion: iOS 14 이상 부터 사용 가능한 셀 등록 방법, register 메서들 같은 메서드 대신 제네릭을 사용, 셀이 생성될 때 마다 클로저가 호출
        cellRegistration = UICollectionView.CellRegistration(handler: { cell, indexPath, itemIdentifier in
            
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
        
        
    }
    
    // 더 빨리 만들어져야 하기 때문에 static으로 선언
    static func createLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.showsSeparators = false
        configuration.backgroundColor = .systemGreen
        
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
}

extension SimpleColletionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: list[indexPath.item])
        
        return cell
    }
    
    
}
