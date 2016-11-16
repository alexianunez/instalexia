//
//  LoginViewModel.swift
//  instalexia
//
//  Created by Alexia Nunez on 11/15/16.
//  Copyright © 2016 Alexia Nunez. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel {
    
    let isLoggingIn: Variable<Bool> = Variable(false)
    let currentError: Variable<String> = Variable("")
    
    func validateInput(userName: String, password: String) -> Observable<Bool> {
        guard !userName.isEmpty && !password.isEmpty else { return Observable.just(false) }
        self.isLoggingIn.value = true
        return Observable.just(true)
    }
    
    func login(userName: String, password: String) {
        
    }
}
