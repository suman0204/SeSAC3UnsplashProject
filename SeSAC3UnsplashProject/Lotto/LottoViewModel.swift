//
//  LottoViewModel.swift
//  SeSAC3UnsplashProject
//
//  Created by 홍수만 on 2023/09/13.
//

import Foundation

class LottoViewModel{
    
    var number1 = LottoObservable("1")
    var number2 = LottoObservable("2")
    var number3 = LottoObservable("3")
    var number4 = LottoObservable("4")
    var number5 = LottoObservable("5")
    var number6 = LottoObservable("6")
    var number7 = LottoObservable("7")
    
    var drawDate = LottoObservable("추첨일")
    
    var lottoMoney = LottoObservable("당첨금")
    
    func format(for number: Int) -> String {
        let numberFormat = NumberFormatter()
        numberFormat.numberStyle = .decimal
        return numberFormat.string(for: number)!
        
    }
    
    func fetchLottoAPI(drwNo: Int) {
        LottoAPIService.shared.requestLotto(drwNo: drwNo) { result in
            
            self.number1.value = "\(result.drwtNo1)"
            self.number2.value = "\(result.drwtNo2)"
            self.number3.value = "\(result.drwtNo3)"
            self.number4.value = "\(result.drwtNo4)"
            self.number5.value = "\(result.drwtNo5)"
            self.number6.value = "\(result.drwtNo6)"
            self.number7.value = "\(result.bnusNo)"
            self.drawDate.value = result.drwNoDate
            self.lottoMoney.value = self.format(for: result.totSellamnt)
            
        } failure: {
            print("Error")
        }

    }
    
}
