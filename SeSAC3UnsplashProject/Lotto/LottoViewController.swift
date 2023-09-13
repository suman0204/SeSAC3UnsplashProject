//
//  LottoViewController.swift
//  SeSAC3UnsplashProject
//
//  Created by 홍수만 on 2023/09/13.
//

import UIKit

class LottoViewController: UIViewController {
    
    @IBOutlet var dateLabel: UILabel!
    
    @IBOutlet var label1: UILabel!
    @IBOutlet var label2: UILabel!
    @IBOutlet var label3: UILabel!
    @IBOutlet var label4: UILabel!
    @IBOutlet var label5: UILabel!
    @IBOutlet var label6: UILabel!
    @IBOutlet var label7: UILabel!
    
    @IBOutlet var totSellamntLabel: UILabel!
    
    var viewModel = LottoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.viewModel.fetchLottoAPI(drwNo: 1000)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
            self.viewModel.fetchLottoAPI(drwNo: 1022)
        }
        
        bindData()
        
    }
    
}

extension LottoViewController {
    
    func bindData() {
        
        viewModel.number1.bind { value in
            self.label1.text = value
        }
        
        viewModel.number2.bind { value in
            self.label2.text = value
        }
        
        viewModel.number3.bind { value in
            self.label3.text = value
        }
        
        viewModel.number4.bind { value in
            self.label4.text = value
        }
        
        viewModel.number5.bind { value in
            self.label5.text = value
        }
        
        viewModel.number6.bind { value in
            self.label6.text = value
        }
        
        viewModel.number7.bind { value in
            self.label7.text = value
        }
        
        viewModel.drawDate.bind { date in
            self.dateLabel.text = date
        }
        
        viewModel.lottoMoney.bind { money in
            self.totSellamntLabel.text = money
        }
    }
    
}
