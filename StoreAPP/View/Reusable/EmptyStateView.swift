//
//  EmptyStateView.swift
//  StoreAPP
//
//  Created by José João Silva Nunes Alves on 02/12/20.
//

import UIKit

class EmptyStateView: UIView {

    let image: UIImageView = {
        let emptyImage = UIImage(named: "empty")?.withTintColor(.systemGray)

        let imageView = UIImageView(image: emptyImage)

        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .systemGray

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground

        self.setup()
        self.configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        self.addSubview(image)
        self.addSubview(label)
    }

    private func configureLayout() {
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            image.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.topAnchor.constraint(equalTo: self.image.bottomAnchor, constant: 8)
        ])
    }
    
    func configure(with title: String) {
        self.label.text = title
    }
}
