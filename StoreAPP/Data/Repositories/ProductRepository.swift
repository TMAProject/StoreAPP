//
//  ProductRepository.swift
//  StoreAPP
//
//  Created by Fernando de Lucas da Silva Gomes on 19/11/20.
//

import Foundation

class ProductRepository: Repository {

    typealias ObjectV = ProductV
    typealias Object = Product

    let service = CoreDataService<Product>()
    var products: [Product] = []

    func getAll() -> [Product] {
        guard let products = service.fetchAll() else { return self.products }
        self.products = products
        return products
    }

    func getFromCategory(from category: Int) -> [Product] {
        let predicate = NSPredicate(format: "category = %@", "\(category)")
        guard let products = service.retrieve(predicate: predicate) else { return [] }
        self.products = products
        return products
    }

    func add(object: ProductV) -> Product? {
        let product = service.new()
        product?.name = object.name
        product?.category = object.category
        product?.idealQuantity = object.idealQuantity
        product?.quantity = object.quatity
        product?.favorite = object.favorite
        if service.save() { return product }
        return nil
    }

    func delete(object: Product) -> Bool {
        service.delete(object: object, shouldSave: true)
        return true
    }

    func get(object: Product) -> Product? {
        let productName = "b"
        let predicate = NSPredicate(format: "id == %@", productName)
        if let product = service.retrieve(predicate: predicate) {
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
        let predicate = NSPredicate(format: "favorite = %@", NSNumber(value: true))
        guard let products = service.retrieve(predicate: predicate) else { return [] }
        return products
    }
}
