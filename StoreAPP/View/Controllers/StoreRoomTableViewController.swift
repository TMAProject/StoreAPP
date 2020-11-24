//
//  StoreRoomTableViewController.swift
//  StoreAPP
//
//  Created by Fernando de Lucas da Silva Gomes on 19/11/20.
//
import UIKit

class StoreRoomTableViewController: UITableViewController {

	init() {
		super.init(style: .grouped)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}

}

// MARK: - UITablewViewDelegate + UItableViewDatasource
extension StoreRoomTableViewController {

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 7
	}

	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return "Favoritos"
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
		cell.textLabel?.text = "Titulo da Label"
		cell.detailTextLabel?.text = "Detalhes da label"
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
		print(
			"""
			\nDeleta o produto pelo viewModel com o
			indexpath \(indexPath), depois recarrega a tableView
			"""
		)
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
