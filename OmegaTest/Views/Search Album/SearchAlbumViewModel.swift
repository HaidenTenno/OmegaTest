//
//  SearchAlbumViewModel.swift
//  OmegaTest
//
//  Created by Петр Тартынских  on 20.06.2021.
//

import Foundation
import Combine

enum SearchAlbumViewModelItemType: String {
    case userInfo = "User"
    case album = "Album"
}

protocol SearchAlbumViewModelSection {
    var items: [SearchAlbumViewModelItem] { get }
}

class SearchAlbumViewModelItem: ViewModelItem {
    var identifier: String
    let type: SearchAlbumViewModelItemType
    
    init(type: SearchAlbumViewModelItemType, identifier: String) {
        self.type = type
        self.identifier = identifier
    }
}

// MARK: - UserInfo section
class SearchAlbumViewModelUserItem: SearchAlbumViewModelItem {
    let value: User
    
    init(type: SearchAlbumViewModelItemType, identifier: String, value: User) {
        self.value = value
        super.init(type: type, identifier: identifier)
    }
}

private final class SearchAlbumViewModelUserInfoSection: SearchAlbumViewModelSection {
    var items: [SearchAlbumViewModelItem] = []
    
    init(user: User) {
        let identifier = Config.IDs.Cells.userInfo
        let item = SearchAlbumViewModelUserItem(type: .userInfo, identifier: identifier, value: user)
        items.append(item)
    }
}

// MARK: - Albums section
class SearchAlbumViewModelAlbumItem: SearchAlbumViewModelItem {
    let value: SearchResult
    
    init(type: SearchAlbumViewModelItemType, identifier: String, value: SearchResult) {
        self.value = value
        super.init(type: type, identifier: identifier)
    }
}

private final class SearchAlbumViewModelAlbumsSection: SearchAlbumViewModelSection {
    var items: [SearchAlbumViewModelItem] = []
    
    init() {}
    
    init(searchResults: [SearchResult]) {
        for result in searchResults.sorted(by: { $0.collectionName < $1.collectionName }) {
            let identifier = Config.IDs.Cells.album
            let item = SearchAlbumViewModelAlbumItem(type: .album, identifier: identifier, value: result)
            items.append(item)
        }
    }
}


protocol SearchAlbumViewModelDelegate: AnyObject {
    func searchAlbumViewModelDidReceiveNewData(_ viewModel: SearchAlbumViewModel)
}

// MARK: - SearchAlbumViewModel
final class SearchAlbumViewModel {
    
    var sections: [SearchAlbumViewModelSection] = []
    
    weak var delegate: SearchAlbumViewModelDelegate?
    
    // Combine
    private var cancellables = Set<AnyCancellable>()
    
    // Services
    private let userRepository: UserRepository
    private let searchRepository: SearchRepository
    
    init(email: String, userRepository: UserRepository, searchRepository: SearchRepository) {
        self.userRepository = userRepository
        self.searchRepository = searchRepository
        setupUser(email: email)
        setupAlbums()
    }
    
    func searchAlbums(query: String) {
        searchRepository.searchAlbum(name: query)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure:
                    #if DEBUG
                    print("LOADING DATA FAIL")
                    #endif
                case .finished:
                    #if DEBUG
                    print("LOADING DATA SUCCESS")
                    #endif
                }
            }, receiveValue: { [weak self] answer in
                guard let self = self else { return }
                self.changeAlbums(searchResults: answer.results)
                self.delegate?.searchAlbumViewModelDidReceiveNewData(self)
            })
            .store(in: &cancellables)
    }
    
    func changeAlbums(searchResults: [SearchResult]) {
        sections.removeAll(where: { $0 is SearchAlbumViewModelAlbumsSection })
        sections.append(SearchAlbumViewModelAlbumsSection(searchResults: searchResults))
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
    
    private func setupAlbums() {
        sections.append(SearchAlbumViewModelAlbumsSection())
    }
}
