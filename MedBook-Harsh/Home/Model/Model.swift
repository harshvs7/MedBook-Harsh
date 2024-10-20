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
    let title: String
    let author_name: [String]?
    let cover_i: Int?
    let ratings_average: Double?
    let ratings_count: Int?
}

struct Book: Codable {
    let title: String
    let author: String
    let coverID: Int?
    let ratingsAverage: Double
    let ratingsCount: Int
}
