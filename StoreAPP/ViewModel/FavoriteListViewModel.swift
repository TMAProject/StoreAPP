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

}

extension FavoriteListViewModel {

    public func getProductViewModel() {
        let array = repository.getFavorites()
        let arrayList = array.compactMap(ProductViewModel.init)
        self.favoritesList = arrayList
    }

    public var numberOfFavorites: Int {
        return self.favoritesList.count
    }

    public func productForCell(at index: Int) -> ProductViewModel? {
        if numberOfFavorites >= index {
            let product = favoritesList[index]
            return product
        } else { return nil}
    }
}
