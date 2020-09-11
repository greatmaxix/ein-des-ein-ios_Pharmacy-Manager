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
        case valid

        func borderColor() -> UIColor {
            switch self {
            case .active, .errorActive:
                return Asset.Colors.appBluePrimary.color
            case .error:
                return Asset.Colors.appError.color
            case .valid:
                return Asset.Colors.appGreen.color
            default:
                return Asset.Colors.appGreyMedium.color
            }
        }

        func backgroundColor() -> UIColor {
            switch self {
            case .plain:
                return Asset.Colors.appGreyLight.color
            default:
                return .white
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

    @IBOutlet private weak var stateIconImageView: UIImageView!
    @IBOutlet private weak var controlsView: UIView!
    @IBOutlet private weak var contentView: UIView!
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
                                                                 attributes: [NSAttributedString.Key.font: UIFont(name: "OpenSans-Regular", size: 14) ?? UIFont.systemFont(ofSize: 14)] )
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
        controlsView.layer.borderWidth = 1
        controlsView.layer.borderColor = state.borderColor().cgColor

        stateIconImageView.isHidden = true

        textField.delegate = self
        textField.keyboardType = keyboardType
//        textField.typingAttributes = typingAttributes()
    }

    func setActive(state: TextFieldState) {
        self.backgroundColor = .clear
        controlsView.layer.borderColor = state.borderColor().cgColor
        controlsView.backgroundColor = state.backgroundColor()

        if state == .error {
            stateIconImageView.isHidden = false
            stateIconImageView.image = Asset.General.iconError.image
        } else if state == .valid {
            stateIconImageView.isHidden = false
            stateIconImageView.image = Asset.General.iconCheck.image
        } else {
            stateIconImageView.isHidden = true
            stateIconImageView.image = Asset.General.iconError.image
        }
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
            let validator = Validator(rules: [EmailRegexRule(errorMessage: "Ой! Неверный формат почты!")])
            if validator.validate(text) == false {
                return (false, "Ой! Неверный формат почты!")
            } else {
                return (true, nil)
            }
        case .password:
            let validator = Validator(rules: [PasswordRule(errorMessage: "Ой! Неверный пароль!")])
            if validator.validate(text) == false {
                return (false, "Ой! Неверная длинна пароля!")
            } else {
                return (true, nil)
            }
        case .nonEmpty:
            let validator = Validator(rules: [RequiredRule(errorMessage: "Ой! Неверные данные!")])
            if validator.validate(text) == false {
                return (false, "Ой! Неверные данные!")
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
                state = .active
            } else if let text = validation.1 {
                state = .errorActive
                setErrorDescription(text: text)
                errorLabel.isHidden = false
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
            state = .valid
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
