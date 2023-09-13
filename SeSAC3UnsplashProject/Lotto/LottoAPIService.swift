//
//  LottoAPIService.swift
//  SeSAC3UnsplashProject
//
//  Created by 홍수만 on 2023/09/13.
//

import Foundation
import Alamofire

class LottoAPIService {
    
    static let shared = LottoAPIService()
    
    private init() { }
    
    func requestLotto(drwNo: Int, success: @escaping (Lotto) -> Void, failure: @escaping () -> Void) {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(drwNo)"
        
        AF.request(url, method: .get).validate().responseDecodable(of: Lotto.self) { response in
            
            switch response.result {
            case .success(let value):
                success(value)
            case .failure(let error):
                print(error)
                failure()
            }
            
        }
    }
    
}
