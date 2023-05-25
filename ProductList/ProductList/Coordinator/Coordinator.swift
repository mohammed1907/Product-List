//
//  Coordinator.swift
//  ProductList
//
//  Created by Farghaly on 24/05/2023.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}
