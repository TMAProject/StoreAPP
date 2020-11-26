//
//  CategoryDetailViewModel.swift
//  StoreAPP
//
//  Created by Alley Pereira on 25/11/20.
//

import UIKit

class ProductListViewController: UITableViewController {

	let category: Category

	let viewModel: ProductListViewModel

	init(category: Category) {
		self.category = category
		self.viewModel = ProductListViewModel(category: category.rawValue)
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
		print("AAAAAAAAAAAAAPRINTEI")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.title = category.title
		navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add,
																 target: self,
																 action: #selector(addButtonAction))
	}

	// MARK: - INITIAL MOCK
	private func createCoreDataMock(_ amount: Int) {
		for _ in 0...amount-1 {
			let newMockProduct = ProductV(name: "Arroize",
										  category: Int16(Category.dry.rawValue),
										  quatity: 4,
										  idealQuantity: 5,
										  favorite: true)

			let newAddedProduct = viewModel.repository.add(object: newMockProduct)
			print(newAddedProduct ?? "")
			print(viewModel.getProductsViewModel().count)
		}
	}

	private func deleteCoreDataMock() {
		guard viewModel.numberOfProducts > 0 else { return }

		for index in 0...viewModel.numberOfProducts-1 {
			_ = viewModel.deleteFromCell(at: index)
		}
	}
	// MARK: - FINAL MOCK
}

// MARK: - UITablewViewDelegate + UItableViewDatasource
extension ProductListViewController {

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.getProductsViewModel().count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		guard let product = viewModel.productForCell(at: indexPath.row) else { return UITableViewCell() }

		let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
		cell.textLabel?.text = product.name
		cell.detailTextLabel?.text = "Qtd: \(product.quantity)/\(product.idealQuantity), Ultima Compra: $1,50 Und"
		cell.accessoryType = .disclosureIndicator
		return cell
	}

	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 75
	}

	private func handleMarkAsFavorite(indexPath: IndexPath) {
		print(
			"""
			\nAtualiza produto e marca como favorito pelo viewModel com o
			indexpath \(indexPath), depois recarrega a tableView
			"""
		)
	}

	private func handleMoveToTrash(indexPath: IndexPath) {
		_ = viewModel.deleteFromCell(at: indexPath.row)
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { // gambiarra aqui
			self.tableView.reloadData()
		}
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
}
