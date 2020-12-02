//
//  RepositoryTest.swift
//  StoreAPPTests
//
//  Created by Academy on 24/11/20.
//

import XCTest
import CoreData
@testable import StoreAPP

class RepositoryTest: XCTestCase {

	var repository: ProductRepository!
	var productMock: Product!

	override func setUp() {
		super.setUp()
		repository = ProductRepository()

		productMock = repository.add(
			object:
				ProductDTO(
					name: "Suco de Limao",
					category: Int16(Category.drinks.rawValue),
					quatity: 1,
					idealQuantity: 5,
					favorite: false
				)
		)
	}

	override func tearDown() {
		_ = repository.delete(object: productMock)
		repository = nil
		productMock = nil
		super.tearDown()
	}

	func test_add_true() {
		// given
		let product = ProductDTO(name: "b", category: 0, quatity: 0, idealQuantity: 0, favorite: true)

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

	override func setUpWithError() throws {
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}

	override func tearDownWithError() throws {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
	}//x-coredata://B068BF7B-9D6D-46FD-81A0-D61C014F6496/Product/p9

	func testExample() throws {
		// This is an example of a functional test case.
		// Use XCTAssert and related functions to verify your tests produce the correct results.
	}

	func testPerformanceExample() throws {
		// This is an example of a performance test case.
		self.measure {
			// Put the code you want to measure the time of here.
		}
	}

}
