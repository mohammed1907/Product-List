//
//  ProductTableViewCell.swift
//  ProductList
//
//  Created by Fraghaly on 24/05/2023.
//

import UIKit
import Kingfisher
import Cosmos

class ProductTableViewCell: UITableViewCell {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productView: UIView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productdescription: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var rateView: CosmosView!
    var data: ProductViewModel? {
        didSet {
            productName.text = data?.name
            productdescription.text = data?.description
            productPrice.text = data?.price
            rateView.rating = data?.rating.approximateToNearestHalf() ?? 0.0

            if let url = URL(string: data?.imageUrl ?? "") {
                productImage.kf.setImage(with: url)
            }
            if data?.isAvailable ?? false {
                productPrice.isHidden = false
                productView.semanticContentAttribute = .forceLeftToRight
            } else {
                productPrice.isHidden = true
                productView.semanticContentAttribute = .forceRightToLeft
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        rateView.settings.fillMode = .precise
        rateView.settings.updateOnTouch = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        selectionStyle = .none
    }

}
