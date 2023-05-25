//
//  Double+Extension.swift
//  ProductList
//
//  Created by Farghaly on 24/05/2023.
//

import Foundation

extension Double {

    // MARK: - get nearest half
    func approximateToNearestHalf() -> Double {
        let roundedValue = (self * 2).rounded() / 2
        return roundedValue
    }
}
