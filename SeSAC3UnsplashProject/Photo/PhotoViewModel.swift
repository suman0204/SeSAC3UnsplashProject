//
//  PhotoViewModel.swift
//  SeSAC3UnsplashProject
//
//  Created by 홍수만 on 2023/09/12.
//

import Foundation

class PhotoViewModel {
    
    var list = Observable(Photo(total: 0, total_pages: 0, results: []))

    func fetchPhoto() {
        APIService.shared.searchPhoto(query: "sky") { photo in
            guard let photo = photo else {
                return
            }
            self.list.value = photo
//            self.tableView.reloadData() //UIKit을 import해야되므로 여기서 다루지 않는다
        }
    }
    
    var rowCount: Int {
        return list.value.results?.count ?? 0
    }
    
    func cellForRowAt(at indexPath: IndexPath) -> PhotoResult {
        return list.value.results![indexPath.row]
    }
}
