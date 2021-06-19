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
            userRepository: RealmUserRepository(),
            onSignedUp: { [unowned self] in
                #if DEBUG
                print("SIGNED UP")
                #endif
                self.navigationController.popViewController(animated: true)
            },
            onHaveAnAccount: { [unowned self] in
                self.navigationController.popViewController(animated: true)
            })
        return signUpVC
    }
    
    private func createSignInVC() -> SignInViewController {
        let signInVC = SignInViewController(
            userRepository: RealmUserRepository(),
            onSignedIn: { email in
                print("SIGNED IN \(email)")
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
        navigationController.pushViewController(signInVC, animated: false)
    }
}
