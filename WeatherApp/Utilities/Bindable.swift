//
//  Bindable.swift
//  NewsApp
//
//  Created by NINAYA-BLRM20 on 09/11/20.
//

import Foundation

class Bindable<T> {
    var value: T? {
        didSet {
            observer?(value)
        }
    }
    
    var observer: ((T?)->())?
    
    func bind(observer: @escaping (T?)->()) {
        self.observer = observer
    }
}
