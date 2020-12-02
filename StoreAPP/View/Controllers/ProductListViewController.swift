//
//  CategoryDetailViewModel.swift
//  StoreAPP
//
//  Created by Alley Pereira on 25/11/20.
//

import UIKit

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
        let createProduct = CreateProductTableViewController()

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
	}

}

// MARK: - UITablewViewDelegate + UItableViewDatasource
extension ProductListViewController {

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModel.numberOfProducts
        if count == 0 {
            self.activateEmptyState()
        }
		return count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		guard let product = viewModel.productForCell(at: indexPath.row) else { return UITableViewCell() }

		let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
		cell.textLabel?.text = product.name
        cell.detailTextLabel?.text = product.description
		cell.accessoryType = .disclosureIndicator
		return cell
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

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt
                                indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let configuration = ContextualAction<ProductListAction>(viewModel, actions: [.delete], index: indexPath.row)
        return configuration.setup()
    }
}

extension ProductListViewController {
    func activateEmptyState() {
        let testeView = EmptyStateView()
        testeView.configure(with: "Sem produtos aqui")
        self.tableView.backgroundView = testeView
    }
}
