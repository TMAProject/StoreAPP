//
//  ProductRepositoryTest.swift
//  StoreAPPTests
//
//  Created by Academy on 24/11/20.
//

import XCTest
import CoreData
@testable import StoreAPP

class ProductRepositoryTest: XCTestCase {

	var repository: ProductRepository!
	var productMock: Product!

    let persistentStore: NSPersistentContainer = {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let container = appDelegate?.persistentContainer
        guard let persistentContainer = container else { fatalError() }
        return persistentContainer
    }()

    func createMockProduct() -> Product {
        let entity = NSEntityDescription.entity(forEntityName: "Product", in: persistentStore.viewContext)
        let product = Product(entity: entity!, insertInto: persistentStore.viewContext)

        product.setValue("productName", forKey: "name")
        product.setValue(1, forKey: "category")
        product.setValue(15, forKey: "idealQuantity")
        product.setValue(10, forKey: "quantity")
        product.setValue(false, forKey: "favorite")

        return product
    }

    override func setUp() {
        repository = ProductRepository()
        productMock = createMockProduct()
    }

	override func tearDown() {
        self.cleanRepository()
		repository = nil
		productMock = nil
	}

    private func cleanRepository() {
        let produtList = repository.getAll()
        for product in produtList {
            _ = repository.delete(object: product)
        }
    }

	func test_add_true() {
		// given
		let product = ProductDTO(product: productMock)

		// when
        let savedProduct = repository.add(object: product)

		// then
		let fetchedProduct = repository.get(object: savedProduct!)
		XCTAssertEqual(fetchedProduct?.name, savedProduct?.name) // estava comparando valores iguais com itens diferentes
	}

	func test_getAll_products_saved() {
		// when
		let fetchedProducts = repository.getAll()
		// then
		XCTAssertEqual(fetchedProducts, repository.products)
	}

	func test_getFromCategory_saved() {

		let category = Category.drinks.rawValue

		let fetchedFromCategory = repository.getFromCategory(from: category)

		for product in fetchedFromCategory {
			XCTAssertEqual(product.category, Int16(category))
		}

	}

	func test_getFromCategory_returnEmptyArray() {

		let fetchedFromCategory = repository.getFromCategory(from: Int(Int16(999)))

		XCTAssertEqual(fetchedFromCategory, [])
	}

	func test_favorite_Product() {

		// when
		let favoriteProduct = repository.favorite(object: productMock)

		// then
		XCTAssertNotNil(favoriteProduct)
		XCTAssertEqual(favoriteProduct!, productMock)
		XCTAssertTrue(favoriteProduct!.favorite)
	}

	func test_unfavorite_Product() {
		// given
		_ = repository.favorite(object: productMock)
		// when
		let unfavoriteProduct = repository.unfavorite(object: productMock)

		// then
		XCTAssertNotNil(unfavoriteProduct)
		XCTAssertEqual(unfavoriteProduct!, productMock)
		XCTAssertFalse(unfavoriteProduct!.favorite)
	}

	func test_delete_product() {
		// when
		let deleteProduct = repository.delete(object: productMock)
		// then
		XCTAssertNotNil(deleteProduct)
	}
}
