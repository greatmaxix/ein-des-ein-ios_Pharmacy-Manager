//
//  StateTextField.swift
//  KyivPost
//
//  Created by Mikhail Timoscenko on 25.06.2020.
//  Copyright © 2020 KyivPost. All rights reserved.
//

import UIKit

protocol StateTextFieldDelegate: class {

    func didBeginEditing()
    func didEndEditing(with result: Bool?)
    func didChange(validation: Bool)

}

class StateTextField: UIView {

    enum TextFieldState {
        case active
        case error
        case plain
        case errorActive

        func underlineColor() -> UIColor? {
            switch self {
            case .active:
                return .black
            case .error, .errorActive:
                return UIColor(named: "indication_red")
            default:
                return UIColor(named: "light_grey")
            }
        }
    }

    enum StateTextFieldValidtionType {
        case none
        case email
        case password
        case phone
        case nonEmpty
    }

    @IBOutlet private weak var alertImageView: UIImageView!
    @IBOutlet private weak var controlsView: UIView!
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var stateView: UIView!
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var errorLabel: UILabel!

    weak var delegate: StateTextFieldDelegate?

    var validationType: StateTextFieldValidtionType = .none

    var keyboardType: UIKeyboardType = .default {
        didSet {
            textField.keyboardType = self.keyboardType
        }
    }

    var text: String? {
        get {
            return textField.text
        }
    }

    var isSecureInput: Bool? {
        didSet {
            if self.isSecureInput == true {
                textField.isSecureTextEntry.toggle()
            }
        }
    }

    var state: TextFieldState = .plain {
        didSet {
            setActive(state: self.state)
        }
    }

    var placeholder: String? {
        didSet {
            textField.attributedPlaceholder = NSAttributedString(string: placeholder ?? "",
                                                                 attributes: [NSAttributedString.Key.font: UIFont(name: "OpenSans-Regular", size: 16) ?? UIFont.systemFont(ofSize: 16)] )
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        commonInit()
    }

    func apply(configuration: StateTextFieldConfiguration) {
        isSecureInput = configuration.isSecure

        if let type = configuration.validationType {
            validationType = type
        }

        if let type = configuration.keyboardType {
            keyboardType = type
        }
    }

    private func commonInit() {
        Bundle.main.loadNibNamed("StateTextField", owner: self, options: nil)
        addSubview(contentView)

        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        textField.delegate = self
        textField.keyboardType = keyboardType
//        textField.typingAttributes = typingAttributes()
    }

    func setActive(state: TextFieldState) {
        self.backgroundColor = .clear
        stateView.backgroundColor = state.underlineColor()
    }

    func isValid() -> Bool {
        let result = validate(text: textField.text ?? "")

        return result.0
    }

}

extension StateTextField {

    private func validate(text: String) -> (Bool, String?) {
        switch validationType {
        case .email:
            let validator = Validator(rules: [EmailRegexRule(errorMessage: L10n.Validator.WrongEmailFormat.title)])
            if validator.validate(text) == false {
                return (false,L10n.Validator.WrongEmailFormat.text)
            } else {
                return (true, nil)
            }
        case .password:
            let validator = Validator(rules: [PasswordRule(errorMessage: L10n.Validator.WrongPasswordLenght.title)])
            if validator.validate(text) == false {
                return (false, L10n.Validator.WrongPasswordLenght.text)
            } else {
                return (true, nil)
            }
        case .phone:
            let validator = Validator(rules: [PhoneRule(errorMessage: L10n.Validator.WrongPhone.title)])
            if validator.validate(text) == false {
                return (false, L10n.Validator.WrongPhone.text)
            } else {
                return (true, nil)
            }
        case .nonEmpty:
            let validator = Validator(rules: [RequiredRule(errorMessage: L10n.Validator.WrongEmptyField.title)])
            if validator.validate(text) == false {
                return (false, L10n.Validator.WrongEmptyField.text)
            } else {
                return (true, nil)
            }
        default:
            return (true, nil)
        }
    }

}

extension StateTextField: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }

//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        delegate?.didBeginEditing()
//
//        state = .active
//    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if let text = textField.text,
            let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            let validation = validate(text: updatedText)

            delegate?.didChange(validation: validation.0)

            if validation.0 == true {
                errorLabel.isHidden = true
                alertImageView.isHidden = true
                state = .active
            } else if let text = validation.1 {
                state = .errorActive
                setErrorDescription(text: text)
                errorLabel.isHidden = false
                alertImageView.isHidden = false
            }
        }

        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {

        guard let _ = textField.text else {
            delegate?.didEndEditing(with: false)
            return
        }

        let validation = validate(text: textField.text ?? "")

        if validation.0 == true {
            errorLabel.isHidden = true
            delegate?.didEndEditing(with: true)
            state = .plain
        } else {
            state = .error
            errorLabel.text = validation.1
            errorLabel.isHidden = false
        }
    }

    // MARK: Helpers

    private func setErrorDescription(text: String) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.98

        errorLabel.attributedText = NSMutableAttributedString(
            string: text,
            attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle]
        )
    }

    private func typingAttributes() -> [NSAttributedString.Key: Any] {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.01

        return [NSAttributedString.Key.paragraphStyle: paragraphStyle]
    }

}
