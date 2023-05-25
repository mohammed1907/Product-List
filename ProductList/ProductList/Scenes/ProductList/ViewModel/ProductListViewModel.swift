//
//  ProductListViewModel.swift
//  ProductList
//
//  Created by Fraghaly on 24/05/2023.
//

import Foundation

protocol ProductListViewModelLogic {
    // MARK: Properties
    var alertMessage: String? { get }
    var state: State { get }
    var numberOfProducts: Int { get }
    var listTitle: String? { get }
    var listSubTitle: String? { get }
    // MARK: Actions
    func getProducts()
    func getCurrentProduct( at indexPath: IndexPath ) -> ProductViewModel
    func filterProducts( at filterID: Int )
    var showAlertClosure: (() -> Void)? { get set }
    var updateLoadingStatus: (() -> Void)? { get set }
    var reloadTableViewClosure: (() -> Void)? { get set }
}

class ProductListViewModel: ProductListViewModelLogic {

    private let apiService: ProductService

    init(apiService: ProductService) {
        self.apiService = apiService
    }

    var listTitle: String?
    var listSubTitle: String?

    // MARK: - API result
    private var products: Products? {
        didSet {
            self.listTitle = products?.header.headerTitle
            self.listSubTitle = products?.header.headerDescription
            self.processProductData(data: products?.products)
        }
    }

    // MARK: - fetched result from ProductViewModel

    private var productList: [ProductViewModel] = [ProductViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    var numberOfProducts: Int {
        return productList.count
    }

    // MARK: - callback for interfaces
    var state: State = .empty {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }

    // MARK: closures for binding
    var showAlertClosure: (() -> Void)?
    var updateLoadingStatus: (() -> Void)?
    var reloadTableViewClosure: (() -> Void)?

    // MARK: - prepare products data
    private func processProductData(data: [Product]?) {
        self.productList = data?.compactMap { ProductViewModel(data: $0) } ?? []
    }

    // MARK: - process fetched result
    func getCurrentProduct( at indexPath: IndexPath ) -> ProductViewModel {
        return productList[indexPath.row]
    }

    // MARK: - Filter

    func filterProducts(at filterID: Int) {
        switch filterID {
        case 2:
            self.productList = products?.products.compactMap { ProductViewModel(data: $0) } ?? []
            self.productList = self.productList.filter({$0.isAvailable == true})
        case 3:
            print("Fav filter")
         // Fav filter
        default:
            self.productList = products?.products.compactMap { ProductViewModel(data: $0) } ?? []
        }
    }

}
// MARK: - Networking
extension ProductListViewModel {
    func getProducts() {
        state = .loading
        apiService.getProducts { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let data):
              self.products = data
              self.state = .populated
            case .failure(let error):
                self.state = .error
                self.alertMessage = error.errorDescription
                    return
            }

        }
    }
}
