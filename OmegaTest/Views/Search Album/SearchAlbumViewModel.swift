//
//  SearchAlbumViewModel.swift
//  OmegaTest
//
//  Created by Петр Тартынских  on 20.06.2021.
//

import Foundation

enum SearchAlbumViewModelItemType: String {
    case userInfo = "User"
    case album = "Album"
}

protocol SearchAlbumViewModelSection {
    var items: [SearchAlbumViewModelItem] { get }
}

final class SearchAlbumViewModelItem: ViewModelItem {
    var identifier: String
    let type: SearchAlbumViewModelItemType
    let value: String
    
    init(type: SearchAlbumViewModelItemType, value: String, identifier: String) {
        self.type = type
        self.value = value
        self.identifier = identifier
    }
}

// MARK: - UserInfo section
private final class SearchAlbumViewModelUserInfoSection: SearchAlbumViewModelSection {
    var items: [SearchAlbumViewModelItem] = []
    
    init(user: User) {
        let value = "\(user.email) (\(user.firstName) \(user.lastName)"
        let identifier = Config.IDs.Cells.userInfo
        let item = SearchAlbumViewModelItem(type: .userInfo, value: value, identifier: identifier)
        items.append(item)
    }
}

// MARK: - Albums section
//private final class SearchAlbumViewModelAlbumsSection: SearchAlbumViewModelSection {
//
//}


// MARK: - SearchAlbumViewModel
final class SearchAlbumViewModel {
    
    var sections: [SearchAlbumViewModelSection] = []
    
    // Services
    private let userRepository: UserRepository
    
    init(email: String, userRepository: UserRepository) {
        self.userRepository = userRepository
        setupUser(email: email)
    }
    
}

// MARK: - Private
private extension SearchAlbumViewModel {
    
    private func setupUser(email: String) {
        userRepository.getSingle(email: email) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure:
                return
            case .success(let user):
                self.sections.append(SearchAlbumViewModelUserInfoSection(user: user))
            }
        }
    }
}
