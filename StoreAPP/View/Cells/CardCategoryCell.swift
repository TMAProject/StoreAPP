//
//  CardCategoryCell.swift
//  StoreAPP
//
//  Created by Fernando de Lucas da Silva Gomes on 19/11/20.
//

import UIKit
class CardCategoryCell: UICollectionViewCell {

    static let reuseIdentifier = "CardCategoryCell"

    let cardImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit

        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .systemGray

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupConstraints()
    }

    func configure(image: UIImage, text: String) {
        self.cardImage.image = image
        self.label.text = text
    }

    func setupView() {
        self.addSubview(cardImage)
        self.addSubview(label)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.cardImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.cardImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.69),
            self.cardImage.bottomAnchor.constraint(equalTo: self.label.topAnchor, constant: -8),
            self.label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.label.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
