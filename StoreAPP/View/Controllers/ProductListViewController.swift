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

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		//		self.tableView.reloadData()
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
		return viewModel.numberOfProducts
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

	private func handleMarkAsFavorite(indexPath: IndexPath) {
        _ = viewModel.favoriteFromCell(at: indexPath.row)
        print(
			"""
			\nAtualiza produto e marca como favorito pelo viewModel com o
			indexpath \(indexPath), depois recarrega a tableView
			"""
		)
	}

	private func handleMoveToTrash(indexPath: IndexPath) {
		_ = viewModel.deleteFromCell(at: indexPath.row)

	}

	override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt
								indexPath: IndexPath) -> UISwipeActionsConfiguration? {

		let swipeFavorite = UIContextualAction(style: .normal,
											   title: "Favorite") { [weak self] (_, _, completionHandler) in

			self?.handleMarkAsFavorite(indexPath: indexPath)
			completionHandler(true)
		}

		swipeFavorite.backgroundColor = .systemGreen
		let configuration = UISwipeActionsConfiguration(actions: [swipeFavorite])

		return configuration
	}

	override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt
								indexPath: IndexPath) -> UISwipeActionsConfiguration? {

		let swipeTrash = UIContextualAction(style: .destructive,
											title: "Trash") { [weak self] (_, _, completionHandler) in

			self?.handleMoveToTrash(indexPath: indexPath)
			completionHandler(true)
		}

		swipeTrash.backgroundColor = .systemRed
		let configuration = UISwipeActionsConfiguration(actions: [swipeTrash])

		return configuration
	}

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let product = viewModel.productForCell(at: indexPath.row)?.product else { return }
        navigationController?.pushViewController(EditProductTableViewController(product: product), animated: true)
    }
}
