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

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    let viewModel = LoginViewModel()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupBindings()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonPressed() {
        guard
            let userName = self.userNameTextField.text,
            let password = self.passwordTextField.text
            else {
            return
        }
        viewModel.validateInput(userName: userName, password: password)
        .subscribe { success in
            guard success.element == true else { return }
            self.doLogin(userName: userName, password: password)
        }.addDisposableTo(disposeBag)
    }
    
    func setupBindings() {
        viewModel.isLoggingIn.asObservable()
        .subscribe(onNext: { (loggingIn) in
            self.enableUI(enable: !loggingIn)
        }, onError: { error in
            self.errorLabel.text = error.localizedDescription
        }, onCompleted: {
            // non-op
        }, onDisposed: {
            // non-op
        }).addDisposableTo(disposeBag)
    
    }
    
    private func doLogin(userName: String, password: String) {
        
    }
    
    private func enableUI(enable: Bool) {
        self.userNameTextField.isUserInteractionEnabled = enable
        self.passwordTextField.isUserInteractionEnabled = enable
        self.loginButton.isUserInteractionEnabled = enable
        self.userNameTextField.alpha = enable ? 1.0: 0.5
        self.passwordTextField.alpha = enable ? 1.0: 0.5
        self.loginButton.alpha = enable ? 1.0: 0.5
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
