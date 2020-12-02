//
//  EditProductTableViewController.swift
//  StoreAPP
//
//  Created by Fernando de Lucas da Silva Gomes on 01/12/20.
//

import Foundation
import UIKit

class EditProductTableViewController: UITableViewController {

    private let formFields: ProductForm = ProductForm.edit

    let viewModel: EditProductViewModel

    init(product: Product) {
        self.viewModel = EditProductViewModel(product)
        super.init(style: .grouped)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.consigurateNavigationBar()
        self.view.backgroundColor = .systemBackground
        self.tableView.register(FieldTableViewCell.self, forCellReuseIdentifier: FieldTableViewCell.reuseIdentifier)
        self.tableView.register(CustomSectionView.self, forHeaderFooterViewReuseIdentifier: CustomSectionView.reuseIdentifier)
        self.tableView.tableFooterView = UIView()
        self.tableView.allowsSelection = false
        viewModel.handleDismiss = {
            self.navigationController?.popViewController(animated: true)
        }
    }

    private func consigurateNavigationBar() {
        self.title = "Edit Product"
        self.isModalInPresentation = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: viewModel, action: #selector(viewModel.save))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: viewModel, action: #selector(viewModel.dismiss))
    }
}

extension EditProductTableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: CustomSectionView.reuseIdentifier) as? CustomSectionView
            guard let headerView = view else { return UIView() }
            headerView.configure(with: viewModel.sectionName(at: section))

            headerView.contentView.backgroundColor = .systemBackground
            return headerView
        }

        let titleView = UITableViewHeaderFooterView()
        titleView.contentView.backgroundColor = .systemBackground

        return titleView
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsForSection(at: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: FieldTableViewCell.reuseIdentifier, for: indexPath) as? FieldTableViewCell

        let fieldName = viewModel.fieldName(section: indexPath.section, index: indexPath.row)
        let fieldValues = viewModel.fieldValues(section: indexPath.section, index: indexPath.row)
        guard let fieldCell = cell else { return FieldTableViewCell() }
        fieldCell.delegate = self.viewModel
        fieldCell.configure(with: fieldName)
        fieldCell.configureField(with: fieldValues)
        return fieldCell
    }
}
