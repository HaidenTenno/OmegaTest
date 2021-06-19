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
    
}

