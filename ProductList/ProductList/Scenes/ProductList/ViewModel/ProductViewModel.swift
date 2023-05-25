//
//  ProductViewModel.swift
//  ProductList
//
//  Created by Fraghaly on 24/05/2023.
//

import Foundation

struct ProductViewModel {
    let id: Int
    let name: String
    let imageUrl: String
    let isAvailable: Bool
    let description: String
    let longDescription: String
    let releaseDate: String
    let rating: Double
    let price: String
    init(data: Product) {
        self.id = data.id
        self.name = data.name
        self.imageUrl = data.imageURL
        self.isAvailable = data.available
        self.description = data.description
        self.longDescription = data.longDescription
        self.releaseDate = data.releaseDate.getDate()
        self.rating = data.rating
        self.price = "Price: \(data.price.value) \(data.price.currency)"
    }
}
