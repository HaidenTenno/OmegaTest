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
                navigationController.popViewController(animated: true)
            },
            onHaveAnAccount: { [unowned self] in
                navigationController.popViewController(animated: true)
            })
        return signUpVC
    }
    
    private func createSignInVC() -> SignInViewController {
        let signInVC = SignInViewController(
            userRepository: RealmUserRepository(),
            onSignedIn: { [unowned self] email in
                #if DEBUG
                print("SIGNED IN \(email)")
                #endif
                presentSearchAlbumScreen(userEmail: email)
            },
            onDontHaveAnAccount: { [unowned self] in
                presentSignUpScreen()
            })
        return signInVC
    }
    
    private func createSearchAlbumVC(userEmail: String) -> SearchAlbumViewController {
        let searchAlbumVC = SearchAlbumViewController(
            viewModel: SearchAlbumViewModel(email: userEmail, userRepository: RealmUserRepository(), searchRepository: ApiSearchRepository(networkService: NetworkServiceImplementation.shared)),
            onAlbumSelect: { [unowned self] searchResult in
                #if DEBUG
                print("ALBUM SELECTED \(searchResult.collectionID)")
                #endif
                presentAlbumViewController(album: searchResult)
            })
        return searchAlbumVC
    }
    
    private func createAlbumViewController(album: SearchResult) -> AlbumViewController {
        let albumVC = AlbumViewController(viewModel: AlbumViewModel(album: album, searchRepository: ApiSearchRepository(networkService: NetworkServiceImplementation.shared)))
        return albumVC
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
    
    private func presentSearchAlbumScreen(userEmail: String) {
        let searchAlbumVC = createSearchAlbumVC(userEmail: userEmail)
        navigationController.pushViewController(searchAlbumVC, animated: true)
    }
    
    private func presentAlbumViewController(album: SearchResult) {
        let albumVC = createAlbumViewController(album: album)
        navigationController.pushViewController(albumVC, animated: true)
    }
}
