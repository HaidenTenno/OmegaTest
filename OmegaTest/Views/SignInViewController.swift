//
//  SignInViewController.swift
//  OmegaTest
//
//  Created by Петр Тартынских  on 18.06.2021.
//

import UIKit
import SnapKit

final class SignInViewController: UIViewController {
    
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
    
//    private var activeTextField: UITextField? = nil
    
    // Services
    private let dateCounter = DateCounter()
    
    // Callbacks
    private let onSignedIn: () -> Void
    private let onDontHaveAnAccount: () -> Void
    
    // Public
    init(onSignedIn: @escaping () -> Void, onDontHaveAnAccount: @escaping () -> Void) {
        self.onSignedIn = onSignedIn
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
//        setupKeyboardNotifications()
    }
}

// MARK: - Private
private extension SignInViewController {
    
    private func setupDoneEditingGesture() {
        let gesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(gesture)
    }
    
//    private func setupKeyboardNotifications() {
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
    
    private func setupDatePicker() {
        ageDatePicker = UIDatePicker()
        ageDatePicker.datePickerMode = .date
        ageDatePicker.preferredDatePickerStyle = .wheels
        ageDatePicker.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
    }
    
    @objc private func dateChanged(datePicker: UIDatePicker) {
        ageTextField.text = String(dateCounter.getYearsFromDate(date: datePicker.date))
    }
    
//    @objc private func keyboardWillShow(notification: NSNotification) {
//        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
//        var shouldMoveViewUp = false
//
//        if let activeTextField = activeTextField {
//            let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: self.view).maxY;
//            let topOfKeyboard = self.view.frame.height - keyboardSize.height
//            if bottomOfTextField > topOfKeyboard {
//                shouldMoveViewUp = true
//            }
//        }
//
//        if shouldMoveViewUp {
//            self.view.frame.origin.y = 0 - keyboardSize.height
//        }
//    }
//
//    @objc private func keyboardWillHide(notification: NSNotification) {
//        self.view.frame.origin.y = 0
//    }
    
    @objc private func onSignInButtonTouched() {
        print("Sign in")
    }
    
    @objc private func onDontHaveAnAccountButtonButtonTouched() {
        print("Dont have an account")
    }
}

// MARK: - UI
private extension SignInViewController {
    
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
        signInButton = ElementsDesigner.getApplyDesignedButton(title: "Sign in")
        signInButton.addTarget(self, action: #selector(onSignInButtonTouched), for: .touchUpInside)
        globalStackView.addArrangedSubview(signInButton)
        
        // dontHaveAnAccountButton
        dontHaveAnAccountButton = ElementsDesigner.getSmallButton(title: "Dont have an account")
        dontHaveAnAccountButton.addTarget(self, action: #selector(onDontHaveAnAccountButtonButtonTouched), for: .touchUpInside)
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
extension SignInViewController: UITextFieldDelegate {
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        self.activeTextField = textField
//    }
//
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        self.activeTextField = nil
//    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard textField == phoneTextField, let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = PnoneNumberFormatter.format(with: "+7 (XXX) XXX-XX-XX", phone: newString)
        return false
    }
}
