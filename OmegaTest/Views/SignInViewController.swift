//
//  SignInViewController.swift
//  OmegaTest
//
//  Created by Петр Тартынских  on 19.06.2021.
//

import UIKit
import SnapKit

class SignInViewController: UIViewController {
    
    // UI
    private var globalStackView: UIStackView!
    private var emailTextField: UITextField!
    private var passwordTextField: UITextField!
    private var signInButton: UIButton!
    private var dontHaveAnAccountButton: UIButton!
    private var spacerView: UIView!
    
    // Services
    private let userRepository: UserRepository
    
    // Callbacks
    private let onSignedIn: (String) -> Void
    private let onDontHaveAnAccount: () -> Void
    
    // Public
    init(userRepository: UserRepository, onSignedIn: @escaping (String) -> Void, onDontHaveAnAccount: @escaping () -> Void) {
        self.userRepository = userRepository
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        clearFields()
    }
}

// MARK: - Private
private extension SignInViewController {
    
    @objc private func onSignInButtonTouched() {
        if !checkEmpty() {
            let alertController = UIAlertController(title: "Error", message: "All fields are required", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        // Check if user exists
        LoadingIndicatorView.show()
        userRepository.signIn(email: emailTextField.text!, password: passwordTextField.text!) { [weak self] result in
            LoadingIndicatorView.hide()
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                switch error {
                case .notFound:
                    let alertController = UIAlertController(title: "Can't sign in", message: "User not found", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Ok", style: .default))
                    self.present(alertController, animated: true, completion: nil)
                case .unauthorized:
                    let alertController = UIAlertController(title: "Can't sign in", message: "Wrong password", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Ok", style: .default))
                    self.present(alertController, animated: true, completion: nil)
                default:
                    let alertController = UIAlertController(title: "Can't sign in", message: "Storage error", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Ok", style: .default))
                    self.present(alertController, animated: true, completion: nil)
                }
            case .success(let user):
                self.onSignedIn(user.email)
            }
        }
        
    }
    
    @objc private func onDontHaveAnAccountButtonButtonTouched() {
        view.endEditing(true)
        onDontHaveAnAccount()
    }
    
    private func checkEmpty() -> Bool {
        if emailTextField.text?.count == 0 ||
            passwordTextField.text?.count == 0
        {
            return false
        }
        
        return true
    }
    
    private func clearFields() {
        emailTextField.text = ""
        passwordTextField.text = ""
        view.endEditing(true)
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
        
        // emailTextField
        emailTextField.snp.makeConstraints { make in
            make.left.equalTo(globalStackView)
            make.right.equalTo(globalStackView)
            make.height.equalTo(40)
        }
        
        // passwordTextField
        passwordTextField.snp.makeConstraints { make in
            make.left.equalTo(globalStackView)
            make.right.equalTo(globalStackView)
            make.height.equalTo(emailTextField)
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
