//
//  LoginViewController.swift
//  SeSAC3UnsplashProject
//
//  Created by jack on 2023/09/12.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet var idTextField: UITextField!
    @IBOutlet var pwTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    
    var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        idTextField.addTarget(self, action: #selector(idTextFieldChanged), for: .editingChanged)
        pwTextField.addTarget(self, action: #selector(pwTextFieldChanged), for: .editingChanged)

        viewModel.id.bind { text in
            print("ID Bind \(text)")
            self.idTextField.text = text
        }
        
        viewModel.pw.bind { text in
            print("PW Bind \(text)")
            self.pwTextField.text = text
        }
        
        viewModel.isValid.bind { bool in
            self.loginButton.isEnabled = bool
            self.loginButton.backgroundColor = bool ? .green : .lightGray
        }
        
    }
    
    @objc func pwTextFieldChanged() {
        print("==")
        viewModel.pw.value = pwTextField.text!
        viewModel.checkValidation()
    }
    
    @objc func idTextFieldChanged() {
        print("==")
        viewModel.id.value = idTextField.text!
        viewModel.checkValidation()
    }
    
    @objc func loginButtonClicked() {
        viewModel.signIn {
            print("로그인 성공했기 때문에 alert 띄우기")
            
        }
//        guard let id = idTextField.text else { return }
//        guard let pw = pwTextField.text else { return }
//
//        if id.count >= 6 && pw == "1234" { // 358,900
//            print("로그인 했어요")
//        } else {
//            print("로그인 실패")
//        }
        
    }
    
}
