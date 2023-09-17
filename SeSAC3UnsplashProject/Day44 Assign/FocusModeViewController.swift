//
//  FocusModeViewController.swift
//  SeSAC3UnsplashProject
//
//  Created by 홍수만 on 2023/09/18.
//

import UIKit
import SnapKit

enum SectionType: Int, CaseIterable {
    case modeSetting = 0
    case share = 1
}

class FocusModeViewController: UIViewController {
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    var dataSource: UICollectionViewDiffableDataSource<SectionType, ModeDetail>!
    
    let modeSettingList = [ModeDetail(title: "방해금지모드", secondTitle: "", label: "켬", image: UIImage(systemName:"moon.fill")!, imageColor: .purple), ModeDetail(title: "수면", secondTitle: "", label: "", image: UIImage(systemName: "bed.double.fill")!, imageColor: .orange), ModeDetail(title: "업무", secondTitle: "09:00~06:00", label: "", image: UIImage(systemName: "iphone")!, imageColor: .green), ModeDetail(title: "개인시간", secondTitle: "", label: "설정", image: UIImage(systemName: "person.fill")!, imageColor: .blue)]
    
    let shareList = [ModeDetail(title: "모든 기기에서 공유", secondTitle: "", label: "", image: UIImage())]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "집중모드"
        view.backgroundColor = .black
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        configureDataSource()
        
        var snapshot = NSDiffableDataSourceSnapshot<SectionType, ModeDetail>()
        snapshot.appendSections(SectionType.allCases)
        snapshot.appendItems(modeSettingList, toSection: .modeSetting)
        snapshot.appendItems(shareList, toSection: .share)
        
        dataSource.apply(snapshot)
    }
    
    static private func layout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.backgroundColor = .black
        
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
    private func configureDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, ModeDetail> { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.title
            content.textProperties.color = .white
            content.secondaryText = itemIdentifier.secondTitle
            content.secondaryTextProperties.color = .white
        
            content.image = itemIdentifier.image
            content.imageProperties.tintColor = itemIdentifier.imageColor
            
            content.prefersSideBySideTextAndSecondaryText = false

            cell.contentConfiguration = content
            
            cell.accessories = [ .label(text: "\(itemIdentifier.label)", options: .init(tintColor: .white))]
            
            
            var backgroundConfig = UIBackgroundConfiguration.listPlainCell()
            backgroundConfig.backgroundColor = .darkGray
            
            cell.backgroundConfiguration = backgroundConfig
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            
            return cell
        })
    }
}
