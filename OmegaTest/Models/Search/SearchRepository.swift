//
//  SearchRepository.swift
//  OmegaTest
//
//  Created by Петр Тартынских  on 20.06.2021.
//

import Foundation
import Combine

protocol SearchRepository: Repository {
    func searchAlbum(name: String) -> AnyPublisher<SearchResult, RepositoryError>
    func lookupAlbum(id: Int) -> AnyPublisher<LookupResult, RepositoryError>
}

final class ApiSearchRepository: SearchRepository {
    
    private var networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func searchAlbum(name: String) -> AnyPublisher<SearchResult, RepositoryError> {
        networkService.load(endpoint: CharacterProvider.Search.searchAlbums(name: name), decodeType: SearchResult.self)
            .mapError { error in
                return RepositoryError.internalError(error)
            }
            .eraseToAnyPublisher()
    }
    
    func lookupAlbum(id: Int) -> AnyPublisher<LookupResult, RepositoryError> {
        networkService.load(endpoint: CharacterProvider.Search.lookupAlbum(id: id), decodeType: LookupResult.self)
            .mapError { error in
                return RepositoryError.internalError(error)
            }
            .eraseToAnyPublisher()
    }
}
