//
//  RandomViewModel.swift
//  SeSAC3UnsplashProject
//
//  Created by 홍수만 on 2023/09/18.
//

import Foundation

class RandomViewModel {
    
    var randomPhotoList: Observable<[RandomPhotoElement]> = Observable([])
    
    var insertedCount: Observable<String?> = Observable("")
    
    var validText: Observable<String?> = Observable("1 ~ 10 사이의 숫자를 입력하세요")
    
    func checkInseredCountValidation() {
        guard let insertedCount = insertedCount.value, let convertNumber = Int(insertedCount) else {
            print("숫자 변환 안됨")
            validText.value = "숫자를 입력하세요"
            return
        }
        
        if convertNumber > 10 || convertNumber < 1 {
            validText.value = "1 ~ 10 사이의 숫자를 입력하세요"
        } else {
            validText.value = "정상적인 입력입니다."
        }
        
//        fetchRandomPhoto(count: convertNumber)
    }
    
    func fetchRandomPhoto(count: Int) {
        APIService.shared.randomPhoto(count: count) { randomPhotos in
            DispatchQueue.main.async {
                self.randomPhotoList.value = randomPhotos
                
                print(self.randomPhotoList.value)
            }
        }
    }
    
}
