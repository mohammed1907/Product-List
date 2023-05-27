//
//  DetailsCoordinator.swift
//  ProductList
//
//  Created by Omar Hassanein on 24/05/2023.
//

import UIKit

class DetailsCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var productViewModel: ProductViewModel!
    init(navigationController: UINavigationController, productViewModel: ProductViewModel) {
        self.navigationController = navigationController
        self.productViewModel = productViewModel
    }

    func start() {
        let viewmodel = ProductDetailsViewModel()
        viewmodel.productInfo = productViewModel
		let storyboard = Storyboard.Main.instance
		let viewcontroller = storyboard.instantiateViewController(identifier: ProductDetailsViewController.storyboardID) { coder in
			return ProductDetailsViewController(coder: coder, coordinator: self, viewModel: viewmodel)
		}
        navigationController.pushViewController(viewcontroller, animated: true)
    }
}
