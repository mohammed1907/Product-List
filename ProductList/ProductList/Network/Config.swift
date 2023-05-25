//
//  Config.swift
//  ProductList
//
//  Created by Farghaly on 24/05/2023.
//

import Foundation

struct Config {
    static let baseURL: String = "https://app.check24.de"
    struct EndpointPath {
        static let getProducts = "/products-test.json"
    }
}
enum HTTPHeaderField: String {
    case contentType = "Content-Type"
}

enum ContentType: String {
    case json = "application/json"
}
