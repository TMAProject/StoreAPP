//
//  CategoriesView.swift
//  StoreAPP
//
//  Created by José João Silva Nunes Alves on 23/11/20.
//

import UIKit
// swiftlint:disable line_length

class CategoriesView: UITableViewHeaderFooterView {

    static let reuseIdentifier = "header"
    
    weak var delegate: CategoryDelegate?

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .systemBackground

        collectionView.register(CardCategoryCell.self, forCellWithReuseIdentifier: CardCategoryCell.reuseIdentifier)

        return collectionView
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
        self.addSubview(collectionView)

        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }

    private func configureLayout() {
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 2),
            self.collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.collectionView.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }

}

extension CategoriesView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = Category.allCases[indexPath.row]
        self.delegate?.didSelectCategory(category: category)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Category.allCases.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.width * 0.19
        return CGSize(width: size, height: size)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let size = collectionView.frame.height * 0.03
        return size
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let size = collectionView.frame.width * 0.07
        return size
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCategoryCell.reuseIdentifier, for: indexPath) as? CardCategoryCell

        guard let cardCategoryCell = cell, let category = Category(rawValue: indexPath.row) else {
            return CardCategoryCell()
        }
        cardCategoryCell.configure(image: category.icon, text: category.title)
        return cardCategoryCell
    }

}
