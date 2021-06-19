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
    private func createSignInVC() -> SignInViewController {
        let signInVC = SignInViewController (
            onSignedIn: {
                print("SIGNED IN")
            },
            onDontHaveAnAccount: {
                print("DONT HAVE AN ACCOUNT")
            })
        return signInVC
    }
    
    // MARK: - Presetners
    private func presentSignInScreen() {
        let signInVC = createSignInVC()
        signInVC.modalPresentationStyle = .fullScreen
        navigationController.present(signInVC, animated: false, completion: nil)
    }
}
