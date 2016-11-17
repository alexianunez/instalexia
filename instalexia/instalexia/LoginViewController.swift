//
//  LoginViewController.swift
//  instalexia
//
//  Created by Alexia Nunez on 11/15/16.
//  Copyright © 2016 Alexia Nunez. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class LoginViewController: ViewController {
    
    let viewModel = LoginViewModel()
    @IBOutlet weak var loginWebView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupBindings()
        self.loadLogin()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setupBindings() {
        // Binding to this flag to detect when user is logged in
        viewModel.userHasLoggedIn.asObservable()
        .subscribe {
            guard $0.element == true else { return }
            // Once the user is logged in, we send the user to the home screen
            self.performSegue(withIdentifier: Constants.Segues.FromLoginToHome.rawValue, sender: self)
        }.addDisposableTo(disposeBag)
    }
    
    private func loadLogin() {
        guard let loginUrl = URL(string: viewModel.loginURL) else { return }
        let loginRequest = URLRequest(url: loginUrl)
        self.loginWebView.loadRequest(loginRequest)
    }
}

extension LoginViewController: UIWebViewDelegate {
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return !viewModel.isAuthTokenPresentInUrl(URL: request.url)
    }
}
