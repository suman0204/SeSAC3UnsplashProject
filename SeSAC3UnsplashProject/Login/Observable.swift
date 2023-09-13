//
//  Observable.swift
//  SeSAC3UnsplashProject
//
//  Created by jack on 2023/09/12.
//

import Foundation

class Observable<T> {
    
    private var listener: ((T) -> Void)?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }

    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void ) {
        print(#function)
        closure(value)
        listener = closure
    }
    
}



