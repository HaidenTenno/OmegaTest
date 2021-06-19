//
//  SignUpViewController.swift
//  OmegaTest
//
//  Created by Петр Тартынских  on 18.06.2021.
//

import UIKit
import SnapKit

final class SignUpViewController: UIViewController {
    
    // UI
    private var globalStackView: UIStackView!
    private var firstNameTextField: UITextField!
    private var lastNameTextField: UITextField!
    private var ageTextField: UITextField!
    private var ageDatePicker: UIDatePicker!
    private var phoneTextField: UITextField!
    private var emailTextField: UITextField!
    private var passwordTextField: UITextField!
    private var signInButton: UIButton!
    private var dontHaveAnAccountButton: UIButton!
    private var spacerView: UIView!
    
    // Services
    private let dateCounter = DateCounter()
    
    // Callbacks
    private let onSignedUp: () -> Void
    private let onDontHaveAnAccount: () -> Void
    
    // Public
    init(onSignedUp: @escaping () -> Void, onDontHaveAnAccount: @escaping () -> Void) {
        self.onSignedUp = onSignedUp
        self.onDontHaveAnAccount = onDontHaveAnAccount
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupDoneEditingGesture()
    }
}

// MARK: - Private
private extension SignUpViewController {
    
    private func setupDoneEditingGesture() {
        let gesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(gesture)
    }
    
    private func setupDatePicker() {
        ageDatePicker = UIDatePicker()
        ageDatePicker.datePickerMode = .date
        ageDatePicker.preferredDatePickerStyle = .wheels
        ageDatePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
    }
    
    @objc private func dateChanged() {
        ageTextField.text = String(dateCounter.getYearsFromDate(date: ageDatePicker.date))
    }
    
    @objc private func onSignInButtonTouched() {
        if !checkEmpty() {
            let alertController = UIAlertController(title: "Error", message: "All fields are required", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        let validationErrors = FormValidator.getValidationErrors(firstName: firstNameTextField.text!, lastName: lastNameTextField.text!, age: ageTextField.text!, pnone: phoneTextField.text!, email: emailTextField.text!, password: passwordTextField.text!)
        if validationErrors.count != 0 {
            let alertController = UIAlertController(title: "Error", message: validationErrors.joined(separator: "\n"), preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        onSignedUp()
    }
    
    @objc private func onHaveAnAccountButtonButtonTouched() {
        onDontHaveAnAccount()
    }
    
    private func checkEmpty() -> Bool {
        if firstNameTextField.text?.count == 0 ||
            lastNameTextField.text?.count == 0 ||
            ageTextField.text?.count == 0 ||
            phoneTextField.text?.count == 0 ||
            emailTextField.text?.count == 0 ||
            passwordTextField.text?.count == 0
        {
            return false
        }
        
        return true
    }
}

// MARK: - UI
private extension SignUpViewController {
    
    private func setupView() {
        // self
        view.backgroundColor = Design.Colors.background
        
        // globalStackView
        globalStackView = UIStackView()
        globalStackView.alignment = .center
        globalStackView.axis = .vertical
        globalStackView.spacing = 20
        globalStackView.distribution = .fill
        view.addSubview(globalStackView)
        
        // firstNameTextField
        firstNameTextField = ElementsDesigner.getDesignedTextField(placeholder: "First name", delegate: self)
        firstNameTextField.keyboardType = .asciiCapable
        globalStackView.addArrangedSubview(firstNameTextField)
        
        // lastNameTextField
        lastNameTextField = ElementsDesigner.getDesignedTextField(placeholder: "Last name", delegate: self)
        lastNameTextField.keyboardType = .asciiCapable
        globalStackView.addArrangedSubview(lastNameTextField)
        
        // ageTextField
        setupDatePicker()
        ageTextField = ElementsDesigner.getDesignedTextField(placeholder: "Age", delegate: self)
        ageTextField.inputView = ageDatePicker
        globalStackView.addArrangedSubview(ageTextField)
        
        // phoneTextField
        phoneTextField = ElementsDesigner.getDesignedTextField(placeholder: "Phone number", delegate: self)
        phoneTextField.keyboardType = .numberPad
        globalStackView.addArrangedSubview(phoneTextField)
        
        // emailTextField
        emailTextField = ElementsDesigner.getDesignedTextField(placeholder: "Email", delegate: self)
        emailTextField.autocorrectionType = .no
        emailTextField.autocapitalizationType = .none
        globalStackView.addArrangedSubview(emailTextField)
        
        // passwordTextField
        passwordTextField = ElementsDesigner.getDesignedTextField(placeholder: "Password", delegate: self)
        passwordTextField.autocorrectionType = .no
        passwordTextField.autocapitalizationType = .none
        passwordTextField.isSecureTextEntry = true
        globalStackView.addArrangedSubview(passwordTextField)
        
        // signInButton
        signInButton = ElementsDesigner.getApplyDesignedButton(title: "Sign up")
        signInButton.addTarget(self, action: #selector(onSignInButtonTouched), for: .touchUpInside)
        globalStackView.addArrangedSubview(signInButton)
        
        // dontHaveAnAccountButton
        dontHaveAnAccountButton = ElementsDesigner.getSmallButton(title: "I have an account")
        dontHaveAnAccountButton.addTarget(self, action: #selector(onHaveAnAccountButtonButtonTouched), for: .touchUpInside)
        globalStackView.addArrangedSubview(dontHaveAnAccountButton)
        
        // spacerView
        spacerView = UIView()
        globalStackView.addArrangedSubview(spacerView)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        // globalStackView
        globalStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        // firstNameTextField
        firstNameTextField.snp.makeConstraints { make in
            make.left.equalTo(globalStackView)
            make.right.equalTo(globalStackView)
            make.height.equalTo(40)
        }
        
        // lastNameTextField
        lastNameTextField.snp.makeConstraints { make in
            make.left.equalTo(globalStackView)
            make.right.equalTo(globalStackView)
            make.height.equalTo(firstNameTextField)
        }
        
        // ageTextField
        ageTextField.snp.makeConstraints { make in
            make.left.equalTo(globalStackView)
            make.right.equalTo(globalStackView)
            make.height.equalTo(firstNameTextField)
        }
        
        // phoneTextField
        phoneTextField.snp.makeConstraints { make in
            make.left.equalTo(globalStackView)
            make.right.equalTo(globalStackView)
            make.height.equalTo(firstNameTextField)
        }
        
        // emailTextField
        emailTextField.snp.makeConstraints { make in
            make.left.equalTo(globalStackView)
            make.right.equalTo(globalStackView)
            make.height.equalTo(firstNameTextField)
        }
        
        // passwordTextField
        passwordTextField.snp.makeConstraints { make in
            make.left.equalTo(globalStackView)
            make.right.equalTo(globalStackView)
            make.height.equalTo(firstNameTextField)
        }
        
        // signInButton
        signInButton.snp.makeConstraints { make in
            make.left.equalTo(globalStackView)
            make.right.equalTo(globalStackView)
            make.height.equalTo(40)
        }
        
        // dontHaveAnAccountButton
        dontHaveAnAccountButton.snp.makeConstraints { make in
            make.left.equalTo(globalStackView)
            make.right.equalTo(globalStackView)
            make.height.equalTo(40)
        }
    }
}

// MARK: - UITextFieldDelegate
extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard textField == phoneTextField, let text = textField.text else { return true }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = PnoneNumberFormatter.format(with: "+7 (XXX) XXX-XX-XX", phone: newString)
        return false
    }
}