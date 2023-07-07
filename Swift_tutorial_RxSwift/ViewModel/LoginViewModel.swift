//
//  LoginViewModel.swift
//  Swift_tutorial_RxSwift
//
//  Created by Trung Nguyễn Quốc on 07/07/2023.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel {
    var emailField: BehaviorSubject<String> = BehaviorSubject(value: "")
    var passwordField: BehaviorSubject<String> = BehaviorSubject(value: "")
    
    
    var isValidEmail: Observable<Bool> {
        emailField.map({ $0.isValidEmail() })
    }
    var isValidPassword: Observable<Bool> {
        passwordField.map{ password in
            return password.count < 6 ? false : true
        }
    }
    
    var isValid: Observable<Bool> {
        return Observable.combineLatest(isValidEmail, isValidPassword).map({$0 && $1})
    }
    
}



//MARK: - Extension Valid Password

extension String {
    func isValidEmail() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}
 

