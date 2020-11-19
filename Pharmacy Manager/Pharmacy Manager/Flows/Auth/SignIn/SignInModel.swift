//
//  SignInModel.swift
//  KyivPost
//
//  Created by Mikhail Timoscenko on 25.06.2020.
//  Copyright © 2020 KyivPost. All rights reserved.
//

import Foundation
import EventsTree

enum SignInEvent: Event {
    case userSignedIn
}

protocol SignInModelInput: class {
    func signIn(email: String, password: String)
}

protocol SignInModelOutput: class {
    func networkingDidComplete(errorText: String?)
}

class SignInModel: Model {

    private var apiLayer = DataManager<AuthAPI, LoginResponse>()

    weak var output: SignInModelOutput!
}

extension SignInModel: SignInModelInput, SignInViewControllerOutput {

    func signIn(email: String, password: String) {



        apiLayer.load(target: .signIn(email: email, password: password)) { [weak self] (result) in
            guard let `self` = self else { return }

            switch result {
            case .success(let response):
                UserSession.shared.authorizationStatus = .authorized(userId: response.user.id)
                UserSession.shared.save(user: response.user, token: response.token)
                self.output.networkingDidComplete(errorText: nil)
                self.raise(event: SignInEvent.userSignedIn)
            case .failure(let error):
                self.output.networkingDidComplete(errorText: error.localizedDescription)
            }
        }
    }

}
