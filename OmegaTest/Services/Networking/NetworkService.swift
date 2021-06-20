//
//  NetworkService.swift
//  OrganizerApp
//
//  Created by Петр Тартынских  on 06.10.2020.
//

import Foundation
import Alamofire
import Combine

enum NetworkServiceError: Error {
    case unauthorized
    case notFound
    case badURL
    case serverError
    case unknownError(_ error: Error)
}

protocol NetworkService {
    func load<Endpoint: URLRequestBuilder, Model: Codable>(endpoint: Endpoint, decodeType: Model.Type) -> AnyPublisher<Model, NetworkServiceError>
}

final class NetworkServiceImplementation: NetworkService {
    
    static let shared = NetworkServiceImplementation()
    
    private init() {}
    
    func load<Endpoint: URLRequestBuilder, Model: Codable>(endpoint: Endpoint, decodeType: Model.Type) -> AnyPublisher<Model, NetworkServiceError> {
        #if DEBUG
        print("Request started: \(endpoint.path)")
        #endif
        guard let urlRequest = endpoint.urlRequest else {
            return Fail(error: NetworkServiceError.badURL).eraseToAnyPublisher()
        }
                
        return AF.request(urlRequest)
            .validate()
            .publishDecodable(type: Model.self)
            .value()
            .mapError{ error in
                #if DEBUG
                print(error)
                #endif
                switch error.responseCode {
                case .some(401):
                    return .unauthorized
                case .some(404):
                    return .notFound
                case .some(500...599):
                    return .serverError
                default:
                    return .unknownError(error)
                }
            }
            .eraseToAnyPublisher()
    }
}
