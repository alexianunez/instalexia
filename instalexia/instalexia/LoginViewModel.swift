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

final class LoginViewModel: ViewModel {
    
    let loginURL = APIConstants.Endpoints.Login.fullURL
    let accessToken: Variable<String> = Variable("")
    let userHasLoggedIn: Variable<Bool> = Variable(false)
    
    override func setupBindings() {
        // Binding to set auth token on API if set
        accessToken.asObservable()
        .subscribe { event in
            // Check first if token is valid, non-zero value
            guard
                let token = event.element,
                token.characters.count > 0
            else { return }
            API.setAuthToken(token: token)
            // Then, get the user's info
            API.getUserInfo()
            // Set this value, so any subscribers can take action
            self.userHasLoggedIn.value = true
        }.addDisposableTo(disposeBag)
    }
    
    func isAuthTokenPresentInUrl(URL: URL?) -> Bool {
        // No need to go further if access token isn't present
        let authTokenFieldName: String = "access_token="
        guard
            let unwrappedUrl = URL,
            let authToken = unwrappedUrl.fragment,
            authToken.contains(authTokenFieldName)
            else {
                return false
        }
        // Extract access token from fragment
        let token = authToken.replacingOccurrences(of: authTokenFieldName, with: "")
        accessToken.value = token
        return true
    }
}
