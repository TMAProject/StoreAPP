//
//  ProductViewModel.swift
//  StoreAPP
//
//  Created by Fernando de Lucas da Silva Gomes on 19/11/20.
//

import Foundation

struct ProductV {
    var name: String
    var category: Int16
    var quatity: Int32
    var idealQuantity: Int32
    var favorite: Bool
}

struct ProductViewModel: ViewModel {

    let product: Product

    init(_ product: Product) {
        self.product = product
    }

}

extension ProductViewModel {

    var name: String {
        return product.name
    }

    var category: Int16 {
        return product.category
    }

    var quantity: Int32 {
        return product.quantity
    }

    var idealQuantity: Int32 {
        return product.idealQuantity
    }

    var favorite: Bool {
        return product.favorite
    }

}
