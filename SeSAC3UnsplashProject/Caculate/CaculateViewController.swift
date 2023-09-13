//
//  CaculateViewController.swift
//  SeSAC3UnsplashProject
//
//  Created by 홍수만 on 2023/09/13.
//

import UIKit

class CaculateViewController: UIViewController {
    
    @IBOutlet var firstTextField: UITextField!
    @IBOutlet var secondTextField: UITextField!
    
    @IBOutlet var resultLabel: UILabel!
    
    @IBOutlet var tempLabel: UILabel!
    
    let viewModel = CaculateViewModel()
    
    @objc func firstTextFieldChanged() {
        viewModel.firstNumber.value = firstTextField.text
        viewModel.calculate()
        viewModel.presentNumberFormat()
    }

    @objc func secondTextFieldChanged() {
        viewModel.secondNumber.value = secondTextField.text
        viewModel.calculate()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstTextField.addTarget(self, action: #selector(firstTextFieldChanged), for: .editingChanged)
        secondTextField.addTarget(self, action: #selector(secondTextFieldChanged), for: .editingChanged)

        
        viewModel.firstNumber.bind { number in
            self.firstTextField.text = number
            print("firstNumber changed \(number)")
        }
        
        viewModel.secondNumber.bind { number in
            self.secondTextField.text = number
            print("secondNumber changed \(number)")
        }

        viewModel.resultText.bind { text in
            self.resultLabel.text = text
        }
        
        viewModel.tempText.bind { text in
            self.tempLabel.text = text
        }
    }
}






//let person = Person("새싹이") //최초로 인스턴스 생성이기 때문에 새싹이는 출력되지 않음
//
//        person.name = "카스타드"
//
//        person.name = "칙촉"
//
//        person.introduce { value in //value - introduce에 있는 sample이 가지고 있는 name
//            self.resultLabel.text = value
//            self.view.backgroundColor = [UIColor.orange, UIColor.lightGray, UIColor.magenta].randomElement()!
//        }
//        //introduce가 계속 실행되는게 아니다
//        //introduce가 실행되면 Person안에 listener에 클로저가 담긴다 -> name이 바뀔 때 마다 didSet에서 listener가 실행된다
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1 ) {
//            person.name = "바나나"
//            print("====1초뒤?===")
//        }
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3 ) {
//            person.name = "키위"
//            print("====3초뒤?===")
//        }
//
//        firstTextField.text = viewModel.firstNumber.value
//        secondTextField.text = viewModel.secondNumber.value
