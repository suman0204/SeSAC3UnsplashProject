//
//  String+Extension.swift
//  SeSAC3UnsplashProject
//
//  Created by jack on 2023/09/11.
//

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localized(number: Int) -> String {
        return String(format: self.localized, number)
    }
    
    
}
