//
//  Double.swift
//  ProductList
//
//  Created by Fraghaly on 24/05/2023.
//

import Foundation

extension Int {

    // MARK: - get day from timestamp

    func getDate() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
            let dayTimePeriodFormatter = DateFormatter()
            dayTimePeriodFormatter.locale = Locale(identifier: "en")
            dayTimePeriodFormatter.dateFormat = "dd MMM YYYY"
            let dateString = dayTimePeriodFormatter.string(from: date as Date)
            return dateString
    }

}
