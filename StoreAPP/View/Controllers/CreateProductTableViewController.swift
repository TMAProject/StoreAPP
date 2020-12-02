//
//  CreateProductTableViewController.swift
//  StoreAPP
//
//  Created by José João Silva Nunes Alves on 25/11/20.
//

import UIKit
// swiftlint:disable line_length

class CreateProductTableViewController: UITableViewController {

    private let formFields: ProductForm = ProductForm.create

    override func viewDidLoad() {
        super.viewDidLoad()
        self.consigurateNavigationBar()

        self.tableView.register(FieldTableViewCell.self, forCellReuseIdentifier: FieldTableViewCell.reuseIdentifier)
        self.tableView.register(CustomSectionView.self, forHeaderFooterViewReuseIdentifier: CustomSectionView.reuseIdentifier)
        self.tableView.tableFooterView = UIView()
        self.tableView.allowsSelection = false
    }

    private func consigurateNavigationBar() {
        self.title = "Novo Produto"
        self.isModalInPresentation = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Salvar", style: .done, target: self, action: #selector(save))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancelar", style: .plain, target: self, action: #selector(cancel))
    }

    @objc func cancel() {
        self.dismiss(animated: true, completion: nil)
    }

    @objc func save() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension CreateProductTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return formFields.sections.count
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: CustomSectionView.reuseIdentifier) as? CustomSectionView
            guard let headerView = view else { return UIView() }
            headerView.configure(with: formFields.sections[section])

            headerView.contentView.backgroundColor = .systemBackground
            return headerView
        }

        let titleView = UITableViewHeaderFooterView()
        titleView.contentView.backgroundColor = .systemBackground

        return titleView
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionName = formFields.sections[section]
        return formFields.fields[sectionName]?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: FieldTableViewCell.reuseIdentifier, for: indexPath) as? FieldTableViewCell

        let sectionName = formFields.sections[indexPath.section]
        let fieldName = formFields.fields[sectionName]?[indexPath.row]

        guard let fieldCell = cell, let label = fieldName else { return FieldTableViewCell() }

        fieldCell.configure(with: label)
        return fieldCell
    }
}
