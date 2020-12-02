//
//  CreateProductTableViewController.swift
//  StoreAPP
//
//  Created by José João Silva Nunes Alves on 25/11/20.
//

import UIKit
// swiftlint:disable line_length

class CreateProductTableViewController: UITableViewController {

    private var viewModel: CreateProductViewModel
    // MARK: TODO - Temporariamente enquanto não temos coordinators
    public var callback: (() -> Void)?

    init(viewModel: CreateProductViewModel) {
        self.viewModel = viewModel
        super.init(style: .grouped)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationBar()

        viewModel.handleDismiss = {
            self.dismiss(animated: true, completion: nil)
            self.callback?()
        }

        self.tableView.register(FieldTableViewCell.self, forCellReuseIdentifier: FieldTableViewCell.reuseIdentifier)
        self.tableView.register(CustomSectionView.self, forHeaderFooterViewReuseIdentifier: CustomSectionView.reuseIdentifier)
        self.tableView.tableFooterView = UIView()
        self.tableView.allowsSelection = false
    }

    private func configureNavigationBar() {
        self.title = "Novo Produto"
        self.isModalInPresentation = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: viewModel, action: #selector(viewModel.save))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: viewModel, action: #selector(viewModel.cancel))
    }

}

extension CreateProductTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: CustomSectionView.reuseIdentifier) as? CustomSectionView
            guard let headerView = view else { return UIView() }
            headerView.configure(with: viewModel.getSectionName(at: section))
            headerView.contentView.backgroundColor = .systemBackground
            return headerView
        }
        let titleView = UITableViewHeaderFooterView()
        titleView.contentView.backgroundColor = .systemBackground
        return titleView
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(at: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: FieldTableViewCell.reuseIdentifier, for: indexPath) as? FieldTableViewCell
        if let fieldName = viewModel.getFieldBySectionName(section: indexPath.section, at: indexPath.row) {
            cell?.configure(label: fieldName)
            viewModel.bindCell(cell: cell)
        }
        return cell ?? UITableViewCell()
    }
}
