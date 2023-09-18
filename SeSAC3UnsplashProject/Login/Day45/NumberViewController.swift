//
//  NumberViewController.swift
//  SeSAC3UnsplashProject
//
//  Created by 홍수만 on 2023/09/18.
//

import UIKit

class NumberViewModel {
    
    func converNumber() {
        
        
        
    }
    
}

class NumberViewController: UIViewController {

    @IBOutlet var numberTextFiled: UITextField!
    
    @IBOutlet var resultLable: UILabel!
    
    let viewModel = NumberViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberTextFiled.addTarget(self, action: #selector(numberTextFieldChanged), for: .editingChanged)

    }

    @objc func numberTextFieldChanged() {
        
        //빈 값, 문자열, 백만원 내에서 환전 가능
        
        guard let text = numberTextFiled.text else {
            resultLable.text = "값을 입력해주세요"
            return
        }
        
        guard let textToNumber = Int(text) else {
            resultLable.text = "100만원 이하의 숫자를 입력해주세요"
            return
        }
        
        guard textToNumber > 0, textToNumber <= 1000000 else {
            resultLable.text = "환전 범주는 100만원 이하입니다."
            return
        }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let decimalNumber = numberFormatter.string(for: textToNumber * 1327)!
        
        resultLable.text = "환전 금액은 \(decimalNumber)입니다."
        
    }

}
