//
//  Repository.swift
//  OmegaTest
//
//  Created by Петр Тартынских  on 19.06.2021.
//

import Foundation

enum RepositoryError: Error {
    case notFound
    case unauthorized
    case describedError(_ string: String)
    case internalError(_ error: Error)
}

protocol Repository {}
