//
//  CardCategoryCell.swift
//  StoreAPP
//
//  Created by Fernando de Lucas da Silva Gomes on 19/11/20.
//

import UIKit
class CardCategoryCell: UICollectionViewCell {

    func config(image: UIImage, text: String) {
    self.cardImage.image = image
    self.label.text = text
    }
    let cardImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11)
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

    func setupView() {
        self.addSubview(cardImage)
        self.addSubview(label)
    }

    func setupConstraints() {
        cardImage.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cardImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            cardImage.topAnchor.constraint(equalTo: self.topAnchor),
            cardImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.69),
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
