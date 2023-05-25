//
//  DetailsViewModel.swift
//  ProductList
//
//  Created by Farghaly on 24/05/2023.
//

import Foundation

protocol ProductDetailsViewModelLogic {
    // MARK: Properties
    var productID: String? { get }
    var productName: String? { get }
    var productDescription: String? { get }
    var productLongDescription: String? { get }
    var productPrice: String? { get }
    var productDate: String? { get }
    var productRate: Double? { get }
    var imageUrl: URL? { get }

    func getFavoriteButtonTitle() -> String
    func isFavorited() -> Bool
    func save(productId: String)
}

class ProductDetailsViewModel: ProductDetailsViewModelLogic {
    // MARK: - Proberities

    var productID: String?
    var productDate: String?

    var productName: String?

    var productDescription: String?

    var productLongDescription: String?

    var productPrice: String?

    var productRate: Double?

    var imageUrl: URL?

    var productInfo: ProductViewModel? {
        didSet {
            processProductData(data: productInfo)

        }
    }

    func isFavorited() -> Bool {
        let favoritesManager = FavoritesManager<FavoriteID>(key: "FavoriteIDs")
        let retrievedFavoriteIDs = favoritesManager.retrieveFavorites()
        for i in retrievedFavoriteIDs {
            if i.id == productID {
                return true
            }
        }
        return false
    }

    func getFavoriteButtonTitle() -> String {
        isFavorited() ? "UnFavorite" : "Favorite"
    }

    func save(productId: String) {
        let favoritesManager = FavoritesManager<FavoriteID>(key: "FavoriteIDs")
        let favoriteID = FavoriteID(id: productId)
        var retrievedFavoriteIDs = favoritesManager.retrieveFavorites()
        for i in retrievedFavoriteIDs {
            if i.id == productId {
                favoritesManager.removeFavorite(favoriteID)
                return
            }
        }
        retrievedFavoriteIDs.append(favoriteID)
        favoritesManager.saveFavorites(retrievedFavoriteIDs)
    }

    // MARK: - process Product data
    private func processProductData(data: ProductViewModel?) {
        productID = "\(data?.id ?? 0)"
        productName =  data?.name
        productDescription = data?.description
        productLongDescription = data?.longDescription
        productPrice = data?.price
        productDate = data?.releaseDate
        productRate = data?.rating.approximateToNearestHalf() ?? 0.0
        if let url = URL(string: data?.imageUrl ?? "") {
            imageUrl = url
        }
    }

}
