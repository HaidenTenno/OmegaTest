//
//  SearchResults.swift
//  OmegaTest
//
//  Created by Петр Тартынских  on 20.06.2021.
//

import Foundation

// MARK: - SearchResults
struct SearchResults: Codable {
    let resultCount: Int
    let results: [SearchResult]
}

// MARK: - SearchResult
struct SearchResult: Codable {
    let artistID, collectionID: Int
    let artistName, collectionName: String
    let artworkUrl60, artworkUrl100: String
    let trackCount: Int
    let releaseDate: String

    enum CodingKeys: String, CodingKey {
        case artistID = "artistId"
        case collectionID = "collectionId"
        case artistName, collectionName, trackCount, artworkUrl60, artworkUrl100, releaseDate
    }
}

// MARK: - LookupResults
struct LookupResults: Codable {
    let resultCount: Int
    let results: [LookupResult]
}

// MARK: - Result
struct LookupResult: Codable {
    let collectionType: String?
    let artistID, collectionID: Int
    let artistName: String
    let collectionName: String
    let artworkUrl60, artworkUrl100: String
    let releaseDate: String
    let trackID: Int?
    let trackName: String?
    let artworkUrl30: String?

    enum CodingKeys: String, CodingKey {
        case collectionType
        case artistID = "artistId"
        case collectionID = "collectionId"
        case artistName, collectionName, artworkUrl60, artworkUrl100, releaseDate
        case trackID = "trackId"
        case trackName, artworkUrl30
    }
}


