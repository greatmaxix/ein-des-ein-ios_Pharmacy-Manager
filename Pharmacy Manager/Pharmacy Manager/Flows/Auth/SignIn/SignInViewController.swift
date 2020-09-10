//
//  SignInViewController.swift
//  KyivPost
//
//  Created by Mikhail Timoscenko on 25.06.2020.
//  Copyright © 2020 KyivPost. All rights reserved.
//

import UIKit

protocol SignInViewControllerInput: SignInModelOutput {}
protocol SignInViewControllerOutput: SignInModelInput {}

class SignInViewController: UIViewController {

    @IBOutlet private weak var emailTextView: StateTextField!
    @IBOutlet private weak var passwordTextView: StateTextField!
    
    var model: SignInViewControllerOutput!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    fileprivate func setupUI() {
        emailTextView.delegate = self
        emailTextView.apply(configuration: StateTextFieldConfiguration.emailConfiguration())
        emailTextView.state = .plain
        emailTextView.placeholder = L10n.email

        passwordTextView.delegate = self
        passwordTextView.apply(configuration: StateTextFieldConfiguration.passwordConfiguration())
        passwordTextView.state = .plain
        passwordTextView.placeholder = L10n.password
    }

    @IBAction func close(_ sender: Any) {
        model.close()
    }

    @IBAction func signUp(_ sender: Any) {
        model.openSignUp()
    }

    @IBAction func signIn(_ sender: Any) {
        performSignIn()
    }

    @IBAction func resetPassword(_ sender: Any) {
        model.openResetPassword()
    }

    private func performSignIn() {
        guard let email = emailTextView.text, let password = passwordTextView.text, emailTextView.isValid(), passwordTextView.isValid() else {
            return
        }

        startLoadingIndicator()
        model.signIn(email: email, password: password)
    }
}

extension SignInViewController: SignInViewControllerInput {

    func networkingDidComplete(errorText: String?) {
        stopLoadingIndicator()

        guard let error = errorText else {
            return
        }

        showError(text: error)
    }

}

extension SignInViewController: StateTextFieldDelegate {

    func didChange(validation: Bool) {

    }

    func didBeginEditing() {

    }

    func didEndEditing(with result: Bool?) {

    }

}
