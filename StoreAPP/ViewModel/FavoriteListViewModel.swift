//
//  FavoriteListViewModel.swift
//  StoreAPP
//
//  Created by Fernando de Lucas da Silva Gomes on 24/11/20.
//

import Foundation

class FavoriteListViewModel {

    var favoritesList: [ProductViewModel] = []
    let repository = ProductRepository()

    var handleUpdate: (() -> Void)?

    var handleRemoveFromCell: ((_ removeAt: IndexPath) -> Void)?
}

extension FavoriteListViewModel {

    public func getFavorites() {
        let array = repository.getFavorites()
        let arrayList = array.compactMap(ProductViewModel.init)
        self.favoritesList = arrayList
    }

    public var numberOfFavorites: Int {
        return self.favoritesList.count
    }

    public func productForCell(at index: Int) -> ProductViewModel? {
        if numberOfFavorites > index {
            let product = favoritesList[index]
            return product
        }
        return nil
    }

    public func unfavoriteFromCell(at index: Int) -> ProductViewModel? {
        if numberOfFavorites > index {
            let product = favoritesList[index]
            _ = repository.unfavorite(object: product.product)
            handleRemoveFromCell?(IndexPath(row: index, section: 1))
            return product
        }
        return nil
    }

    public func deleteFromCell(at index: Int) -> Product? {
        if numberOfFavorites > index {
            let product = favoritesList[index]
            _ = repository.delete(object: product.product)
            handleRemoveFromCell?(IndexPath(row: index, section: 1))
            return product.product
        }
        return nil
    }
}

extension FavoriteListViewModel: SwipeActionDelegate {
    func didPerform(action: SwipeAction, index: Int) {
        guard let action = action as? ProductListAction else { return }
        switch action {
        case .delete: _ = deleteFromCell(at: index)
        case .unfavorite: _ = unfavoriteFromCell(at: index)
        default: _ = unfavoriteFromCell(at: index)
        }
    }
}
