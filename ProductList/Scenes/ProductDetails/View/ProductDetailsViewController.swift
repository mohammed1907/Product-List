//
//  ProductDetailsViewController.swift
//  ProductList
//
//  Created by Farghaly on 24/05/2023.
//

import UIKit
import Cosmos
import Kingfisher
final class ProductDetailsViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var rateView: CosmosView! {
        didSet {
            rateView.settings.fillMode = .precise
            rateView.settings.updateOnTouch = false
        }
    }
    @IBOutlet weak var productLongDescription: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var releaseDate: UILabel!

    // MARK: - Properties
	private var coordinator: DetailsCoordinator?
    private var viewModel: ProductDetailsViewModelLogic!

	required init?(coder: NSCoder, coordinator: DetailsCoordinator?, viewModel: ProductDetailsViewModelLogic) {
		self.coordinator = coordinator
		self.viewModel = viewModel
		super.init(coder: coder)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	deinit {
		print(self)
	}

}

// MARK: - Life Cycle
extension ProductDetailsViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
    }
}
// MARK: - Setup Data
private extension ProductDetailsViewController {
    func setupData() {
        favoriteButton.setTitle(viewModel.getFavoriteButtonTitle(), for: .normal)
        productName.text =  viewModel.productName
        productDescription.text = viewModel.productDescription
        productLongDescription.text = viewModel.productLongDescription
        productPrice.text = viewModel.productPrice
        rateView.rating = viewModel.productRate?.approximateToNearestHalf() ?? 0.0
        productImage.kf.setImage(with: viewModel.imageUrl)
        releaseDate.text = viewModel.productDate

    }
}

private extension ProductDetailsViewController {
    @IBAction func favPressed(_ sender: Any) {
        viewModel.save(productId: viewModel.productID ?? "")
        favoriteButton.setTitle(viewModel.getFavoriteButtonTitle(), for: .normal)

    }
}
