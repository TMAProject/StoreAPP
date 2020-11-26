//
//  ProductListViewModel.swift
//  StoreAPP
//
//  Created by Fernando de Lucas da Silva Gomes on 24/11/20.
//

import Foundation

class ProductListViewModel {

    var productList: [ProductViewModel] = []
    let repository = ProductRepository()
    let category: Category

    init(category: Category) {
        self.category = category
    }
}

extension ProductListViewModel {
    public func getProductsViewModel() -> [ProductViewModel] {
		let array = repository.getFromCategory(from: self.category.rawValue)
        let arrayList = array.compactMap(ProductViewModel.init)
        self.productList = arrayList
        return arrayList
    }

    public var numberOfProducts: Int {
        return self.productList.count
    }

    public func productForCell(at index: Int) -> ProductViewModel? {
        if numberOfProducts >= index {
            let product = productList[index]
            return product
        } else { return nil }
    }

    public func deleteFromCell(at index: Int) -> Product? {
        if numberOfProducts >= index {
            let product = productList[index]
            _ = repository.delete(object: product.product)
            return product.product
        } else { return nil }
    }

    public func favoriteFromCell(at index: Int) -> ProductViewModel? {
        if numberOfProducts >= index {
            let product = productList[index]
            _ = repository.favorite(object: product.product)
            return product
        } else { return nil}
    }

}
