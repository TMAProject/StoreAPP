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
    
    var handleUpdate: (() ->())?
}

extension FavoriteListViewModel {

    public func getFavorites() {
        let array = repository.getFavorites()
        let arrayList = array.compactMap(ProductViewModel.init)
        self.favoritesList = arrayList
        handleUpdate?()
    }

    public var numberOfFavorites: Int {
        return self.favoritesList.count
    }

    public func productForCell(at index: Int) -> ProductViewModel? {
        if numberOfFavorites >= index {
            let product = favoritesList[index]
            return product
        } else { return nil }
    }

    public func unfavoriteFromCell(at index: Int) -> ProductViewModel? {
        if numberOfFavorites >= index {
            let product = favoritesList[index]
            _ = repository.unfavorite(object: product.product)
            favoritesList.remove(at: index)
            handleUpdate?()
            return product
        } else { return nil }
    }

    public func deleteFromCell(at index: Int) -> Product? {
        if numberOfFavorites >= index {
            let product = favoritesList[index]
            _ = repository.delete(object: product.product)
            favoritesList.remove(at: index)
            handleUpdate?()
            return product.product
        } else { return nil }
    }
}
