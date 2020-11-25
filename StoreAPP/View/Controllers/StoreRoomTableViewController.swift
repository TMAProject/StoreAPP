//
//  StoreRoomTableViewController.swift
//  StoreAPP
//
//  Created by Fernando de Lucas da Silva Gomes on 19/11/20.
//
import UIKit
// swiftlint:disable line_length

class StoreRoomTableViewController: UITableViewController {

	init() {
		super.init(style: .grouped)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
        self.tableView.register(CategoriesView.self, forHeaderFooterViewReuseIdentifier: CategoriesView.reuseIdentifier)
        self.view.backgroundColor = .systemBackground

        self.configureNavigation()
	}

    private func configureNavigation() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Store room"
    }
}

// MARK: - UITablewViewDelegate + UItableViewDatasource
extension StoreRoomTableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: CategoriesView.reuseIdentifier) as? CategoriesView
            guard let headerView = view else { return UIView() }
            return headerView
        }

        let titleView = UITableViewHeaderFooterView()
        titleView.contentView.backgroundColor = .systemGray5

        return titleView
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            let size = self.view.frame.height * 0.25
            return size
        }

        return self.view.frame.height * 0.05
    }

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        }

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
