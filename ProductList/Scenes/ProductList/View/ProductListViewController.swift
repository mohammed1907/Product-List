//
//  ViewController.swift
//  ProductList
//
//  Created by Farghaly on 24/05/2023.
//

import UIKit

final class ProductListViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var listTitle: UILabel!
    @IBOutlet weak var listSubTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    // MARK: - Properties

    private let refreshControl = UIRefreshControl()
	private var coordinator: MainCoordinator?
    private var viewModel: ProductListViewModelLogic!

	required init?(coder: NSCoder, coordinator: MainCoordinator?, viewModel: ProductListViewModelLogic) {
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
extension ProductListViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBinding()
    }
}

// MARK: - Setup UI
private extension ProductListViewController {
    func setupUI() {
        setupTableView()
        setupRefresh()
    }

    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib.init(nibName: ProductTableViewCell.identifier, bundle: nil),
                           forCellReuseIdentifier: ProductTableViewCell.identifier)
    }

    func setupRefresh() {
        refreshControl.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        refreshControl.addTarget(self, action: #selector(refresh(_:)),
                                 for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
}

// MARK: - Setup Binding
private extension ProductListViewController {
    func setupBinding() {
        viewModel.showAlertClosure = { [weak self] () in
            DispatchQueue.main.async {
                if let message = self?.viewModel.alertMessage {
                    print(message)
                }
            }
        }

        viewModel.updateLoadingStatus = { [weak self] () in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                switch self.viewModel.state {
                case .empty, .error:
                    self.showAlert(self.viewModel.alertMessage ?? "")
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                case .loading:
                    self.activityIndicator.startAnimating()
                    self.activityIndicator.isHidden = false
                case .populated:
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                }
            }
        }

        viewModel.reloadTableViewClosure = { [weak self] () in
            guard let self = self else {
                return
            }
            self.listTitle.text = self.viewModel.listTitle
            self.listSubTitle.text = self.viewModel.listSubTitle
            self.tableView.reloadData()
        }
        viewModel.getProducts()
    }

}

// MARK: - TableView DataSource
extension ProductListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfProducts
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath)
                as? ProductTableViewCell else {
            fatalError("Cell not exists in storyboard")
        }
        cell.data = viewModel.getCurrentProduct( at: indexPath )
        return cell
    }
}
// MARK: - TableView Delegate
extension ProductListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.navigateToNewScreen(with: viewModel.getCurrentProduct(at: indexPath))
    }
}
// MARK: - Actions
extension ProductListViewController {
    @IBAction func filterPressed(_ sender: UIButton) {
        viewModel.filterProducts(at: sender.tag)

    }

    @objc private func refresh(_ sender: AnyObject) {
        setupBinding()
        refreshControl.endRefreshing()
    }

    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
