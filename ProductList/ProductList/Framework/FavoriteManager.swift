//
//  FavoriteManager.swift
//  ProductList
//
//  Created by Omar Hassanein on 24/05/2023.
//

import Foundation

class FavoritesManager<T: Codable & Equatable> {
    private let favoritesKey: String

    init(key: String) {
        self.favoritesKey = key
    }

    func saveFavorites(_ favorites: [T]) {
        do {
            let encodedData = try JSONEncoder().encode(favorites)
            UserDefaults.standard.set(encodedData, forKey: favoritesKey)
        } catch {
            print("Failed to encode favorites: \(error)")
        }
    }

    func retrieveFavorites() -> [T] {
        guard let data = UserDefaults.standard.data(forKey: favoritesKey) else {
            return []
        }

        do {
            let decodedData = try JSONDecoder().decode([T].self, from: data)
            return decodedData
        } catch {
            print("Failed to decode favorites: \(error)")
            return []
        }
    }

    func removeFavorite(_ favorite: T) {
        var favorites = retrieveFavorites()
        if let index = favorites.firstIndex(where: { $0 == favorite }) {
            favorites.remove(at: index)
            saveFavorites(favorites)
        }
    }
}

struct FavoriteID: Codable, Equatable {
    let id: String
}
