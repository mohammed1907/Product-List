//
//  Products.swift
//  ProductList
//
//  Created by Farghaly on 24/05/2023.
//

import Foundation

// MARK: - Products
struct Products: Codable {
    let header: Header
    let filters: [String]
    let products: [Product]
}

// MARK: - Header
struct Header: Codable {
    let headerTitle, headerDescription: String
}

// MARK: - Product
struct Product: Codable {
    let name: String
    let type: String
    let id: Int
    let color: String
    let imageURL: String
    let colorCode: String
    let available: Bool
    let releaseDate: Int
    let description, longDescription: String
    let rating: Double
    let price: Price
}

// MARK: - Price
struct Price: Codable {
    let value: Double
    let currency: String
}
