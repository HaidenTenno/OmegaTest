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
        presentSignUpScreen()
    }
}

// MARK: - Private
private extension ViewsCoordinator {
    
    // MARK: - Creators
    private func createSignUpVC() -> SignUpViewController {
        let signUpVC = SignUpViewController (
            onSignedUp: {
                print("SIGNED UP")
            },
            onDontHaveAnAccount: {
                print("I HAVE AN ACCOUNT")
            })
        return signUpVC
    }
    
    // MARK: - Presetners
    private func presentSignUpScreen() {
        let signUpVC = createSignUpVC()
        signUpVC.modalPresentationStyle = .fullScreen
        navigationController.present(signUpVC, animated: false, completion: nil)
    }
}
