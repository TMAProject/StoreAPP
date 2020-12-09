//
//  ProductRepository.swift
//  StoreAPP
//
//  Created by Fernando de Lucas da Silva Gomes on 19/11/20.
//

import Foundation

class ProductRepository: Repository {

    typealias ObjectDTO = ProductDTO
    typealias Object = Product

    let service = CoreDataService<Product>()
    var products: [Product] = []

    func getAll() -> [Product] {
        guard let products = service.fetchAll() else { return self.products }
        self.products = products
        return products
    }

    func getFromCategory(from category: Int) -> [Product] {
        let predicateEnum = ProductPredicate.getFromCategory(category: category)
        guard let products = service.retrieve(predicate: predicateEnum.predicate) else { return [] }
        self.products = products
        return products
    }

    func add(object: ProductDTO) -> Product? {
        let product = service.new()
        product?.name = object.name
        product?.category = object.category
        product?.idealQuantity = object.idealQuantity
        product?.quantity = object.quatity
        product?.favorite = object.favorite
        if service.save() { return product }
        return nil
    }

    func delete(object: Product) -> Product? {
        guard let product = service.delete(object: object) else { return nil }
        return product
    }

    func get(object: Product) -> Product? {
        let predicateEnum = ProductPredicate.getFromId(identifier: object.name)
        if let product = service.retrieve(predicate: predicateEnum.predicate) {
            return product.first
        }
        return nil
    }

    func favorite(object: Product) -> Product? {
        if !object.favorite {
            object.favorite = true
            _ = service.save()
            return object
        }
           return nil
    }

    func unfavorite(object: Product) -> Product? {
        if object.favorite {
            object.favorite = false
            _ = service.save()
            return object
        }
           return nil
    }

    func getFavorites() -> [Product] {
        let predicateEnum = ProductPredicate.getFavorite
        guard let products = service.retrieve(predicate: predicateEnum.predicate) else { return [] }
        return products
    }
}
