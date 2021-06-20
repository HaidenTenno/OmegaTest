//
//  URLRequestBuilder.swift
//  OrganizerApp
//
//  Created by Петр Тартынских  on 06.10.2020.
//

import Foundation
import Alamofire

protocol URLRequestBuilder: URLRequestConvertible {
    var baseURL: String { get }
    var path: String { get }
    var headers: HTTPHeaders? { get }
    var parameters: Parameters? { get }
    var method: HTTPMethod { get }
}

extension URLRequestBuilder {
    
    var baseURL: String {
        return "https://itunes.apple.com"
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
        
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        
        request.allHTTPHeaderFields = headers?.dictionary
        request = try JSONEncoding.default.encode(request, with: parameters)
        
        return request
    }
}

enum CharacterProvider {
    
    enum Search: URLRequestBuilder {
        case searchAlbums(name: String)
        case lookupAlbum(id: Int)
        
        var path: String {
            switch self {
            case .searchAlbums:
                return "search"
            case .lookupAlbum:
                return "lookup"
            }
        }
        
        var headers: HTTPHeaders? {
            return nil
        }
        
        var parameters: Parameters? {
            switch self {
            case .searchAlbums(let name):
                return ["term": name,
                        "entity": "album"]
            case .lookupAlbum(let id):
                return ["id": id,
                        "entity": "song"]
            }
        }
        
        var method: HTTPMethod {
            return .get
        }
    }
}

