//
//  FieldTableViewCell.swift
//  StoreAPP
//
//  Created by José João Silva Nunes Alves on 25/11/20.
//

import UIKit

class FieldTableViewCell: UITableViewCell {

    static let reuseIdentifier = "FieldTableViewCell"

    let textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemBackground
        textField.clearButtonMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
        self.configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        self.contentView.isUserInteractionEnabled = false

        self.addSubview(textField)
    }

    private func configureLayout() {
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: self.topAnchor),
            textField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            textField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            textField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    func configure(label with: String) {
        self.textField.placeholder = with
    }
}
