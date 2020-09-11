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

//    private var apiLayer = DataManager<AuthAPI, User>()

    weak var output: SignInModelOutput!

}

extension SignInModel: SignInModelInput, SignInViewControllerOutput {

    func signIn(email: String, password: String) {

        raise(event: SignInEvent.userSignedIn)

//        apiLayer.load(target: .signIn(email: email, password: password)) { [weak self] (result) in
//            guard let `self` = self else { return }
//
//            switch result {
//            case .success(let user):
//                do {
//                    try UserSession.shared.save(user: user)
//                } catch let error {
//                     print("Save Error - \(error.localizedDescription)")
//                }
//                self.close()
//                self.output.networkingDidComplete(errorText: nil)
//            case .failure(.objectMapping(let error as KyivPostError, _)):
//                self.output.networkingDidComplete(errorText: error.error)
//            case .failure(let error):
//                self.output.networkingDidComplete(errorText: error.localizedDescription)
//            }
//        }
    }

}
