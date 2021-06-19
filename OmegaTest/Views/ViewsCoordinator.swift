//
//  ViewsCoordinator.swift
//  OmegaTest
//
//  Created by Петр Тартынских  on 18.06.2021.
//

import UIKit

final class ViewsCoordinator {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.isHidden = false
    }
    
    func start() {
        presentSignInScreen()
    }
}

// MARK: - Private
private extension ViewsCoordinator {
    
    // MARK: - Creators
    private func createSignUpVC() -> SignUpViewController {
        let signUpVC = SignUpViewController(
            onSignedUp: {
                print("SIGNED UP")
            },
            onHaveAnAccount: { [unowned self] in
                self.navigationController.popViewController(animated: true)
            })
        return signUpVC
    }
    
    private func createSignInVC() -> SignInViewController {
        let signInVC = SignInViewController(
            onSignedIn: {
                print("SIGNED IN")
            },
            onDontHaveAnAccount: { [unowned self] in
                presentSignUpScreen()
            })
        return signInVC
    }
    
    // MARK: - Presetners
    private func presentSignUpScreen() {
        let signUpVC = createSignUpVC()
        navigationController.pushViewController(signUpVC, animated: true)
    }
    
    private func presentSignInScreen() {
        let signInVC = createSignInVC()
//        signInVC.modalPresentationStyle = .fullScreen
//        navigationController.present(signInVC, animated: false, completion: nil)
        navigationController.pushViewController(signInVC, animated: false)
    }
}
