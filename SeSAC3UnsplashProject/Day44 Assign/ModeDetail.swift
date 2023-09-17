//
//  ModeDetail.swift
//  SeSAC3UnsplashProject
//
//  Created by 홍수만 on 2023/09/18.
//

import UIKit

struct ModeDetail: Hashable {
    let id = UUID().uuidString
    
    var title: String
    var secondTitle: String
    var label: String
    
    var image: UIImage?
    var imageColor: UIColor?
}
