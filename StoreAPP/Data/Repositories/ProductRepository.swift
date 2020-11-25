//
//  ProductRepository.swift
//  StoreAPP
//
//  Created by Fernando de Lucas da Silva Gomes on 19/11/20.
//

import Foundation

struct ProductRepository: Repository {

    typealias ObjectV = ProductV
    typealias Object = Product

    let service = CoreDataService<Product>()
    var products: [Product] = []

    func getAll() -> [Product] {
          return products
    }

    func add(object: ProductV) -> Product? {
        let product = service.new()
        product.name = object.name
        product.category = object.category
        product.idealQuantity = object.idealQuantity
        product.quantity = object.quatity
        product.favorite = object.favorite
        if service.save() { return product }
        return nil
    }

    func delete(object: Product) -> Bool {
        service.deleteProduct(product: object, shouldSave: true)
        return true
    }

    func get(object: Product) -> Product? {
        let productName = "b"
        let predicate = NSPredicate(format: "id == %@", productName)
        if let product = service.retrieveProduct(from: object, predicate: predicate) {
            return product
        }
        return nil
    }
}
