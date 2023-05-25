//
//  ProductService.swift
//  ProductList
//
//  Created by Fraghaly on 24/05/2023.
//

import Foundation

protocol ProductService {
    func getProducts(completion: @escaping (Result<Products, NetworkError>) -> Void)
}

class ProductServiceImpl: ProductService {
    private let service = NetworkService()

    func getProducts(completion: @escaping (Result<Products, NetworkError>) -> Void) {
        return service.fetchRequest(forRoute: .getProducts, completion: completion)
    }

}
