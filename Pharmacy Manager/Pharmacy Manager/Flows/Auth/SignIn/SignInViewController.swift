//
//  SignInViewController.swift
//  KyivPost
//
//  Created by Mikhail Timoscenko on 25.06.2020.
//  Copyright © 2020 KyivPost. All rights reserved.
//

import UIKit
import MBProgressHUD

protocol SignInViewControllerInput: SignInModelOutput {}
protocol SignInViewControllerOutput: SignInModelInput {}

class SignInViewController: UIViewController {

    @IBOutlet private weak var emailTextView: StateTextField!
    @IBOutlet private weak var passwordTextView: StateTextField!
    @IBOutlet weak var enterLabel: UILabel!
    @IBOutlet weak var signInButton: UIButton!

    private lazy var activityIndicator: MBProgressHUD = {
        let hud = MBProgressHUD(view: view)
        hud.backgroundView.style = .solidColor
        hud.backgroundView.color = UIColor.black.withAlphaComponent(0.2)
        hud.removeFromSuperViewOnHide = false
        view.addSubview(hud)

        return hud
    }()

    var model: SignInViewControllerOutput!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    fileprivate func setupUI() {
        emailTextView.delegate = self
        emailTextView.apply(configuration: StateTextFieldConfiguration.emailConfiguration())
        emailTextView.state = .plain
        emailTextView.placeholder = "Почта"

        passwordTextView.delegate = self
        passwordTextView.apply(configuration: StateTextFieldConfiguration.passwordConfiguration())
        passwordTextView.state = .plain
        passwordTextView.placeholder = "Пароль"
    }

    @IBAction func signIn(_ sender: Any) {
        guard let email = emailTextView.text, let password = passwordTextView.text else {
            return
        }
        activityIndicator.show(animated: true)
        model.signIn(email: email, password: password)
    }
}

extension SignInViewController: SignInViewControllerInput {

    func networkingDidComplete(errorText: String?) {
        activityIndicator.hide(animated: true)

        guard let error = errorText else {
            return
        }

        showError(text: error)
    }

}

extension SignInViewController: StateTextFieldDelegate {

    func didChange(validation: Bool) {
        if emailTextView.isValid() && passwordTextView.isValid() {
            signInButton.isUserInteractionEnabled = true
            signInButton.setImage(Asset.Auth.btnGoActive.image, for: .normal)
            enterLabel.textColor = Asset.Colors.appBluePrimary.color
        } else {
            signInButton.isUserInteractionEnabled = false
            signInButton.setImage(Asset.Auth.btnGoInactive.image, for: .normal)
            enterLabel.textColor = Asset.Colors.appGrey.color
        }
    }

    func didBeginEditing() {

    }

    func didEndEditing(with result: Bool?) {

    }

}
