//
//  ProductTableViewCell.swift
//  StoreAPP
//
//  Created by José João Silva Nunes Alves on 07/12/20.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    static let reuseIdentifier = "ProductTableViewCell"

    let primaryText: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let secondaryText: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let icon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit

        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        self.addSubview(self.primaryText)
        self.addSubview(self.secondaryText)
        self.addSubview(self.icon)
    }

    private func configureLayout() {

        NSLayoutConstraint.activate([
            self.icon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.icon.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -40),
            self.icon.widthAnchor.constraint(equalTo: self.icon.widthAnchor)
        ])

        NSLayoutConstraint.activate([
            self.primaryText.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            self.primaryText.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            self.primaryText.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7)
        ])

        NSLayoutConstraint.activate([
            self.secondaryText.topAnchor.constraint(equalTo: self.primaryText.bottomAnchor, constant: 8),
            self.secondaryText.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            self.secondaryText.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7)
        ])
    }

    func configure(primaryText: String, secondaryText: String, iconName: String) {
        self.primaryText.text = primaryText
        self.secondaryText.text = secondaryText

        self.icon.image = UIImage(systemName: iconName)
        self.icon.tintColor = .systemGreen
    }
}
