//
//  FieldTableViewCell.swift
//  StoreAPP
//
//  Created by José João Silva Nunes Alves on 25/11/20.
//

import UIKit

class FieldTableViewCell: UITableViewCell {

    static let reuseIdentifier = "FieldTableViewCell"

    weak var delegate: ProductFieldDelegate?
    var identifier: ProductFields?

    let textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemBackground
        textField.clearButtonMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let label: UILabel = {
           let label = UILabel()
           label.font = .systemFont(ofSize: 17, weight: .regular)
           label.textColor = .label

           label.translatesAutoresizingMaskIntoConstraints = false
           return label

       }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
        self.configureLayout()
        self.textField.addTarget(self, action: #selector(didChanged), for: .editingChanged)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        self.contentView.isUserInteractionEnabled = false
        self.addSubview(label)
        self.addSubview(textField)
    }

    private func configureLayout() {
        NSLayoutConstraint.activate([
              label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
              label.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.38),
              label.centerYAnchor.constraint(equalTo: self.centerYAnchor),

              textField.topAnchor.constraint(equalTo: self.topAnchor),
              textField.leftAnchor.constraint(equalTo: self.label.rightAnchor, constant: 16),
              textField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
              textField.heightAnchor.constraint(equalToConstant: 44)
          ])
    }

    func configure(with label: String) {
        self.identifier = ProductFields(rawValue: label)
        self.textField.placeholder = label
        self.label.text = label
    }

    func configureField(with text: String) {
        self.textField.text = text
    }
}

extension FieldTableViewCell {
    @objc func didChanged(textField: UITextField) {
        if let text = textField.text, let identifier = self.identifier {
            self.delegate?.didUpdateTextField(text: text, field: identifier)
        }
    }
}
