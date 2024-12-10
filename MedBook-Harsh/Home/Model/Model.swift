//
//  Model.swift
//  MedBook-Harsh
//
//  Created by Harshvardhan Sharma on 19/10/24.
//

import Foundation

enum SortOption {
    case title
    case averageRating
    case hits
}

struct BookResponse: Codable {
    let docs: [BookDoc]
}

struct BookDoc: Codable {
    let title: String?
    let authorName: [String]?
    let coverI: Int?
    let ratingsAverage: Double?
    let ratingsCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case title
        case authorName = "author_name"
        case coverI = "cover_i"
        case ratingsAverage = "ratings_average"
        case ratingsCount = "ratings_count"
    }
}

struct Book: Codable {
    let title: String?
    let author: String?
    let coverID: Int?
    let ratingsAverage: Double?
    let ratingsCount: Int?
}
