//
//  AlbumTableViewModel.swift
//  OmegaTest
//
//  Created by Петр Тартынских  on 20.06.2021.
//

import Foundation
import Combine

enum AlbumViewModelItemType: String {
    case info = "Info"
    case track = "Track"
}

protocol AlbumViewModelSection {
    var items: [AlbumViewModelItem] { get }
}

class AlbumViewModelItem: ViewModelItem {
    var identifier: String
    let type: AlbumViewModelItemType
    
    init(type: AlbumViewModelItemType, identifier: String) {
        self.type = type
        self.identifier = identifier
    }
}

// MARK: - AlbumInfo section
class AlbumViewModelInfoItem: AlbumViewModelItem {
    let value: SearchResult
    
    init(type: AlbumViewModelItemType, identifier: String, value: SearchResult) {
        self.value = value
        super.init(type: type, identifier: identifier)
    }
}

final class AlbumViewModelInfoSection: AlbumViewModelSection {
    var items: [AlbumViewModelItem] = []
    
    init(searchResult: SearchResult) {
        let identifier = Config.IDs.Cells.albumInfo
        let item = AlbumViewModelInfoItem(type: .info, identifier: identifier, value: searchResult)
        items.append(item)
    }
}

// MARK: - Tracks section
class AlbumViewModelTrackItem: AlbumViewModelItem {
    let value: LookupResult
    
    init(type: AlbumViewModelItemType, identifier: String, value: LookupResult) {
        self.value = value
        super.init(type: type, identifier: identifier)
    }
}

final class AlbumViewModelTrackSection: AlbumViewModelSection {
    var items: [AlbumViewModelItem] = []
    
    init(lookupResults: [LookupResult]) {
        for result in lookupResults {
            guard let _ = result.trackName else { continue }
            let identifier = Config.IDs.Cells.track
            let item = AlbumViewModelTrackItem(type: .track, identifier: identifier, value: result)
            items.append(item)
        }
    }
}

protocol AlbumViewModelDelegate: AnyObject {
    func albumViewModelDidReceiveNewData(_ viewModel: AlbumViewModel)
}

// MARK: - AlbumViewModel
final class AlbumViewModel {
    
    var sections: [AlbumViewModelSection] = []
    
    weak var delegate: AlbumViewModelDelegate?
    
    // Combine
    private var cancellables = Set<AnyCancellable>()
    
    // Services
    private let searchRepository: SearchRepository
    
    init(album: SearchResult, searchRepository: SearchRepository) {
        self.searchRepository = searchRepository
        setupAlbum(album: album)
        setupTracks(albumID: album.collectionID)
    }
}

// MARK: - Private
private extension AlbumViewModel {
    
    private func setupAlbum(album: SearchResult) {
        sections.append(AlbumViewModelInfoSection(searchResult: album))
    }
    
    private func setupTracks(albumID: Int) {
        searchRepository.lookupAlbum(id: albumID)
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
                self.sections.append(AlbumViewModelTrackSection(lookupResults: answer.results))
                self.delegate?.albumViewModelDidReceiveNewData(self)
            })
            .store(in: &cancellables)
    }
}
