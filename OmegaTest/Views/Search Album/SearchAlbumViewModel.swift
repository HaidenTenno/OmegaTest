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
    
    func changeResult(searchResult: [SearchResult]) {
        items.removeAll()
        for result in searchResult.sorted(by: { $0.collectionName < $1.collectionName }) {
            let identifier = Config.IDs.Cells.album
            let item = SearchAlbumViewModelAlbumItem(type: .album, identifier: identifier, value: result)
            items.append(item)
        }
    }
}


// MARK: - SearchAlbumViewModel
final class SearchAlbumViewModel {
    
    @Published var sections: [SearchAlbumViewModelSection] = []
    
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
                
                for album in answer.results {
                    print(album.collectionName)
                }
                
                self?.changeAlbums(searchResults: answer.results)
            })
            .store(in: &cancellables)
    }
    
    func changeAlbums(searchResults: [SearchResult]) {
        for section in sections {
            guard let albumsSection = section as? SearchAlbumViewModelAlbumsSection else { continue }
            albumsSection.changeResult(searchResult: searchResults)
        }
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
