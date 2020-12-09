//
//  CustomSectionView.swift
//  StoreAPP
//
//  Created by José João Silva Nunes Alves on 26/11/20.
//

import UIKit

class CustomSectionView: UITableViewHeaderFooterView {
    static let reuseIdentifier = "CustomSectionView"

    let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = .label

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let lineViewTop: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = .systemGray4

        lineView.translatesAutoresizingMaskIntoConstraints = false
        return lineView
    }()

    let lineViewBottom: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = .systemGray4

        lineView.translatesAutoresizingMaskIntoConstraints = false
        return lineView
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.setup()
        self.configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        self.addSubview(label)
        //self.addSubview(lineViewTop)
        self.addSubview(lineViewBottom)
        self.backgroundColor = .systemBackground
    }

    func configure(with label: String) {
        self.label.text = label
    }

    private func configureLayout() {
        NSLayoutConstraint.activate([
            self.label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            self.label.topAnchor.constraint(equalTo: self.topAnchor, constant: 48),
            self.label.bottomAnchor.constraint(equalTo: self.lineViewBottom.topAnchor, constant: -8)
        ])

//        NSLayoutConstraint.activate([
//            self.lineViewTop.topAnchor.constraint(equalTo: self.topAnchor),
//            self.lineViewTop.heightAnchor.constraint(equalToConstant: 0.5),
//            self.lineViewTop.leftAnchor.constraint(equalTo: self.label.leftAnchor),
//            self.lineViewTop.rightAnchor.constraint(equalTo: self.rightAnchor)
//        ])

        NSLayoutConstraint.activate([
            self.lineViewBottom.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.lineViewBottom.heightAnchor.constraint(equalToConstant: 0.5),
            self.lineViewBottom.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
}
