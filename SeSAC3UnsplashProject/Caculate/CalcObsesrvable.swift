//
//  CalcObsesrvable.swift
//  SeSAC3UnsplashProject
//
//  Created by 홍수만 on 2023/09/13.
//

import Foundation

class CustomObservable<T> {
    
    private var listener: ((T) -> Void)? //클래스 내부에서만 사용되기 때문에 private
    
    var value: T { //값이 바뀔 때 마다 알려주고 싶다
        didSet {
            listener?(value) //nil이면 함수 호출하지 않음
            print("사용자의 이름이 \(value)로 변경되었습니다.")
        }
    }
    
    init(_ value: T) { //매개변수명 생략할 수 있도록 _(와일드카드 식별자) 사용 // 명확한 매개변수일 때 사용, 두 가지 이상의 매개변수일 때 모든 매개변수에 사용하지 않고 첫 번째 매개변수에만 사용
        self.value = value
    }
    
    func bind(_ sample: @escaping (T) -> Void) { // String 타입을 받아오고 싶다 -> 모든 타입에 대응하기 위해 T로 바꿈
        print("저는 \(value)입니다.")
        sample(value) // 뷰에 전달
        listener = sample
    }
}
