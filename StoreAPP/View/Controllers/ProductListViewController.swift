//
//  CategoryDetailViewModel.swift
//  StoreAPP
//
//  Created by Alley Pereira on 25/11/20.
//

import UIKit
// swiftlint:disable line_length

class ProductListViewController: UITableViewController {

	let viewModel: ProductListViewModel

	init(viewModel: ProductListViewModel) {
		self.viewModel = viewModel
		super.init(style: .grouped)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	@objc private func addButtonAction() {
        let createViewModel = CreateProductViewModel(category: viewModel.category)
        let createProduct = CreateProductTableViewController(viewModel: createViewModel)
        createProduct.callback = {
            _ = self.viewModel.getProductsViewModel()
            self.viewModel.handleUpdate?()
        }
        let navController = UINavigationController(rootViewController: createProduct)
        self.navigationController?.present(navController, animated: true, completion: nil)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.title = viewModel.category.title
        self.view.backgroundColor = .systemBackground
		_ = viewModel.getProductsViewModel()
		navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add,
																 target: self,
																 action: #selector(addButtonAction))
        viewModel.handleUpdate = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }

        viewModel.handleRemoveFromCell = { index in
            self.tableView.beginUpdates()
            self.viewModel.productList.remove(at: index.row)
            self.tableView.deleteRows(at: [index], with: .automatic)
            self.tableView.endUpdates()
        }

        self.tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.reuseIdentifier)
	}

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        _ = self.viewModel.getProductsViewModel()
        self.viewModel.handleUpdate?()
    }

}

// MARK: - UITablewViewDelegate + UItableViewDatasource
extension ProductListViewController {

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModel.numberOfProducts
        if count == 0 {
            self.activateEmptyState()
        } else {
            self.deactivateEmptyState()
        }
		return count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		guard let product = viewModel.productForCell(at: indexPath.row) else { return UITableViewCell() }

        let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.reuseIdentifier, for: indexPath) as? ProductTableViewCell
        guard let productCell = cell else {
            return UITableViewCell()
        }
        let iconName = product.favorite ? "star.fill" : ""
        productCell.configure(primaryText: product.name, secondaryText: product.description, iconName: iconName)
        productCell.accessoryType = .disclosureIndicator

		return productCell
	}

	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 75
	}

    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt
                                indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let configuration: ContextualAction<ProductListAction>!
        if viewModel.productList[indexPath.row].favorite {
            configuration = ContextualAction<ProductListAction>(viewModel, actions: [.unfavorite], index: indexPath.row)
        } else {
            configuration = ContextualAction<ProductListAction>(viewModel, actions: [.favorite], index: indexPath.row)
        }
        return configuration.setup()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let product = viewModel.productForCell(at: indexPath.row)?.product else { return }
        navigationController?.pushViewController(EditProductTableViewController(product: product), animated: true)
    }
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt
                                indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let configuration = ContextualAction<ProductListAction>(viewModel, actions: [.delete], index: indexPath.row)
        return configuration.setup()
    }
}

extension ProductListViewController {
    func activateEmptyState() {
        let emptyView = EmptyStateView()
        emptyView.configure(with: "Sem produtos aqui")
        self.tableView.backgroundView = emptyView
    }

    func deactivateEmptyState() {
        self.tableView.backgroundView = nil
    }
}
