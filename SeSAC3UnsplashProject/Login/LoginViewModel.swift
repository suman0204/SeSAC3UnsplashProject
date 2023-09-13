//
//  LoginViewModel.swift
//  SeSAC3UnsplashProject
//
//  Created by 홍수만 on 2023/09/12.
//

import Foundation

class LoginViewModel {
    
    var id = Observable("")
    var pw = Observable("")
    var isValid = Observable(false) // 뷰가 validation이 됐는지 안됐는지만 알게해준다
    
    func checkValidation() {
        if id.value.count >= 6 /*&& pw.value.count >= 4*/ {
            isValid.value = true
        } else {
            isValid.value = false
        }
    }
    
    func signIn(completion: @escaping () -> Void) {
        
        //서버, 닉네임, id, email 등을 유저디폴트에 저장될 수 있다
        UserDefaults.standard.set(id.value, forKey: "id")
        
        completion()
    }
}
