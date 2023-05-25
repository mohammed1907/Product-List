//
//  Storyboarded.swift
//  ProductList
//
//  Created by Farghaly on 24/05/2023.
//

import UIKit

enum Storyboard: String {
    case main = "Main"
}

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {

        let fullName = NSStringFromClass(self)

        let className = fullName.components(separatedBy: ".")[1]

        let mainStoryboard = UIStoryboard(name: Storyboard.main.rawValue, bundle: Bundle.main)

        guard let soryboard = mainStoryboard.instantiateViewController(withIdentifier: className) as? Self else {
            fatalError()
        }
        return soryboard
    }
}
