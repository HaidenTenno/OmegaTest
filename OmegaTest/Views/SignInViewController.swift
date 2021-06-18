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
    
    private var activeTextField: UITextField? = nil
    
    // Services
    private let dateCounter = DateCounter()
    
    // Callbacks
    
    
    // Public
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupDoneEditingGesture()
        setupKeyboardAppear()
    }
}

// MARK: - Private
private extension SignInViewController {
    
    private func setupDoneEditingGesture() {
        let gesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(gesture)
    }
    
    private func setupKeyboardAppear() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupDatePicker() {
        ageDatePicker = UIDatePicker()
        ageDatePicker.datePickerMode = .date
        ageDatePicker.preferredDatePickerStyle = .wheels
        ageDatePicker.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
    }
    
    @objc private func dateChanged(datePicker: UIDatePicker) {
        ageTextField.text = String(dateCounter.getYearsFromDate(date: datePicker.date))
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        var shouldMoveViewUp = false
        
        if let activeTextField = activeTextField {
            let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: self.view).maxY;
            let topOfKeyboard = self.view.frame.height - keyboardSize.height
            if bottomOfTextField > topOfKeyboard {
                shouldMoveViewUp = true
            }
        }
        
        if(shouldMoveViewUp) {
            self.view.frame.origin.y = 0 - keyboardSize.height
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
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
        globalStackView.distribution = .fillEqually
        view.addSubview(globalStackView)
        
        // firstNameTextField
        firstNameTextField = UITextField()
        firstNameTextField.keyboardType = .asciiCapable
        firstNameTextField.backgroundColor = Design.Colors.fieldBackground
        firstNameTextField.layer.borderWidth = 1.0
        firstNameTextField.layer.borderColor = Design.Colors.fieldBorder.cgColor
        firstNameTextField.placeholder = "First name"
        firstNameTextField.addDoneButtonOnKeyboard()
        firstNameTextField.delegate = self
        globalStackView.addArrangedSubview(firstNameTextField)
        
        // lastNameTextField
        lastNameTextField = UITextField()
        lastNameTextField.keyboardType = .asciiCapable
        lastNameTextField.backgroundColor = Design.Colors.fieldBackground
        lastNameTextField.layer.borderWidth = 1.0
        lastNameTextField.layer.borderColor = Design.Colors.fieldBorder.cgColor
        lastNameTextField.placeholder = "Last name"
        lastNameTextField.addDoneButtonOnKeyboard()
        lastNameTextField.delegate = self
        globalStackView.addArrangedSubview(lastNameTextField)
        
        // ageTextField
        setupDatePicker()
        ageTextField = UITextField()
        ageTextField.inputView = ageDatePicker
        ageTextField.backgroundColor = Design.Colors.fieldBackground
        ageTextField.layer.borderWidth = 1.0
        ageTextField.layer.borderColor = Design.Colors.fieldBorder.cgColor
        ageTextField.placeholder = "Age"
        ageTextField.addDoneButtonOnKeyboard()
        ageTextField.delegate = self
        globalStackView.addArrangedSubview(ageTextField)
        
        // phoneTextField
        phoneTextField = UITextField()
        phoneTextField.keyboardType = .numberPad
        phoneTextField.backgroundColor = Design.Colors.fieldBackground
        phoneTextField.layer.borderWidth = 1.0
        phoneTextField.layer.borderColor = Design.Colors.fieldBorder.cgColor
        phoneTextField.placeholder = "Phone number"
        phoneTextField.addDoneButtonOnKeyboard()
        phoneTextField.delegate = self
        globalStackView.addArrangedSubview(phoneTextField)
        
        // emailTextField
        emailTextField = UITextField()
        emailTextField.autocorrectionType = .no
        emailTextField.autocapitalizationType = .none
        emailTextField.backgroundColor = Design.Colors.fieldBackground
        emailTextField.layer.borderWidth = 1.0
        emailTextField.layer.borderColor = Design.Colors.fieldBorder.cgColor
        emailTextField.placeholder = "Email"
        emailTextField.addDoneButtonOnKeyboard()
        emailTextField.delegate = self
        globalStackView.addArrangedSubview(emailTextField)
        
        // passwordTextField
        passwordTextField = UITextField()
        passwordTextField.autocorrectionType = .no
        passwordTextField.autocapitalizationType = .none
        passwordTextField.backgroundColor = Design.Colors.fieldBackground
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.borderColor = Design.Colors.fieldBorder.cgColor
        passwordTextField.isSecureTextEntry = true
        passwordTextField.placeholder = "Password"
        passwordTextField.addDoneButtonOnKeyboard()
        passwordTextField.delegate = self
        globalStackView.addArrangedSubview(passwordTextField)
        
        // signInButton
        
        
        // dontHaveAnAccountButton
        
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        // globalStackView
        globalStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-50)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-50)
        }
        
        // firstNameTextField
        firstNameTextField.snp.makeConstraints { make in
            make.left.equalTo(globalStackView)
            make.right.equalTo(globalStackView)
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
        
        
        // dontHaveAnAccountButton
        
    }
}

// MARK: - UITextFieldDelegate
extension SignInViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeTextField = nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
