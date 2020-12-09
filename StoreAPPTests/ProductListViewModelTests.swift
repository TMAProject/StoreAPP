//
//  ProductListViewModelTests.swift
//  StoreAPPTests
//
//  Created by Academy on 30/11/20.
//

import XCTest
import CoreData
@testable import StoreAPP

private struct MockSwipeAction: SwipeAction {
	var color: UIColor
	var title: String = ""
	var style: UIContextualAction.Style
}

class ProductListViewModelTests: XCTestCase {

	var viewModel: ProductListViewModel!
	var service: CoreDataService<Product>!
	var product: Product!
	var listOfProducts: [Product]!

	override func setUp() {
		super.setUp()
		viewModel = ProductListViewModel(category: .candies)
		service = CoreDataService<Product>()
		listOfProducts = []
	}

	override func tearDown() {
		cleanRepository(listOfProducts: listOfProducts)
		if let product = product {
			cleanRepository(listOfProducts: [product])
		}
		viewModel = nil
		service = nil
		product = nil
		listOfProducts = nil
		super.tearDown()
	}

	func test_getProductsViewModel_allProducts10() {
		// given
		let productList = createMockProductsDTO()
		listOfProducts = productList.compactMap { viewModel.repository.add(object: $0) }
		// when
		let allProducts = viewModel.getProductsViewModel()
		// then
		XCTAssertEqual(allProducts.count, 10)
	}

	func test_numberOfProducts_10() {
		// given
		viewModel.productList = createMockProducts()
		// when
		let numberOfProducts = viewModel.numberOfProducts
		// then
		XCTAssertEqual(numberOfProducts, 10)
	}

	func test_productForCell_productRice() {
		// given
		let product = service.new()
		product?.name = "productRice"
		viewModel.productList.append(ProductViewModel(product!))
		// when
		let productFromCell = viewModel.productForCell(at: 0)
		// then
		XCTAssertEqual(productFromCell?.name, "productRice")
		_ = service.delete(object: product!)
	}

	func test_productForCell_Nil() {
		// given -> nil
		// when
		let productFromCell = viewModel.productForCell(at: 0)
		// then
		XCTAssertNil(productFromCell)
	}

	func test_deleteFromCell_productBeans() {
		// given
		let product = service.new()
		product?.name = "productBeans"
		viewModel.productList.append(ProductViewModel(product!))
		// when
		let deletedFromCell = viewModel.deleteFromCell(at: 0)
		// then
		XCTAssertEqual(deletedFromCell?.name, "")
		_ = service.delete(object: product!)
	}

	func test_deleteFromCell_Nil() {
		// given -> nil
		// when
		let deletedFromCell = viewModel.deleteFromCell(at: 0)
		// then
		XCTAssertNil(deletedFromCell)
	}

	func test_favoriteFromCell_productFavoriteTrue() {
		// given
		let product = service.new()
		product?.favorite = false
		viewModel.productList.append(ProductViewModel(product!))
		// when
		let favoritedFromCell = viewModel.favoriteFromCell(at: 0)
		// then
		XCTAssertEqual(favoritedFromCell?.favorite, true)
		_ = service.delete(object: product!)
	}

	func test_favoriteFromCell_Nil() {
		// given -> nil
		// when
		let favoritedFromCell = viewModel.favoriteFromCell(at: 0)
		// then
		XCTAssertNil(favoritedFromCell)
	}

	func test_unfavoriteFromCell() {
		// given
		let index = 1
		viewModel.productList = createMockProducts()
		let expectedProduct = viewModel.productList[index]
		// when
		let unfavoriteProduct = viewModel.unfavoriteFromCell(at: index)
		// then
		XCTAssertNotNil(unfavoriteProduct)
		XCTAssertEqual(unfavoriteProduct, expectedProduct)
		XCTAssertEqual(unfavoriteProduct?.favorite, false)
	}

	func test_unfavoriteFromCell_ReturnNil() {
		// given -> nil
		// when
		let unfavoriteProduct = viewModel.unfavoriteFromCell(at: 0)
		// then
		XCTAssertNil(unfavoriteProduct)
	}

	func test_performSwipeAction_isNotProductListAction() {
		// given
		viewModel.productList = createMockProducts()
		let expectedProductList = viewModel.productList
		let swipeAction = MockSwipeAction(color: .red, style: .normal)
		let index = 0
		// when
		viewModel.didPerform(action: swipeAction, index: index)
		// then
		for (index, value) in expectedProductList.enumerated() {
			XCTAssertEqual(value, viewModel.productList[index])
		}
	}

	func test_performSwipeAction_deleteListAction() {
		// given
		let product = createMockProduct()
		viewModel.productList.append(ProductViewModel(product))
		let swipeActionDelete = ProductListAction.delete
		let index = 0
		let expectedAmountOfProducts = service.fetchAll()!.count - 1

		// when
		viewModel.didPerform(action: swipeActionDelete, index: index)

		// then
		XCTAssertEqual(service.fetchAll()!.count, expectedAmountOfProducts)
		_ = service.delete(object: product)
	}

	func test_performSwipeAction_favoriteListAction() {
		// given
		let product = createMockProduct()
		product.favorite = false
		viewModel.productList.append(ProductViewModel(product))
		let swipeActionFavorite = ProductListAction.favorite
		let index = 0

		// when
		viewModel.didPerform(action: swipeActionFavorite, index: index)

		// then
		XCTAssertTrue(product.favorite)
		_ = service.delete(object: product)
	}

	func test_performSwipeAction_unfavoriteListAction() {
		// given
		let product = createMockProduct()
		product.favorite = true
		viewModel.productList.append(ProductViewModel(product))
		let swipeActionUnfavorite = ProductListAction.unfavorite
		let index = 0

		//when
		viewModel.didPerform(action: swipeActionUnfavorite, index: index)

		// then
		XCTAssertFalse(product.favorite)
		_ = service.delete(object: product)
	}

	// Mock Functions.
	private func createMockProducts() -> [ProductViewModel] {
		let product = createMockProduct()
		self.product = product
		let productList = Array(repeating: ProductViewModel(product), count: 10)
		return productList
	}

	func createMockProduct() -> Product {
		let product = service.new()
		product?.setValue("productName", forKey: "name")
		product?.setValue(1, forKey: "category")
		product?.setValue(15, forKey: "idealQuantity")
		product?.setValue(10, forKey: "quantity")
		product?.setValue(false, forKey: "favorite")
		return product!
	}

	private func createMockProductsDTO() -> [ProductDTO] {
		var productList = [ProductDTO]()
		for _ in 0..<10 {
			productList.append(ProductDTO(name: "productName",
										  category: 1, quatity: 15,
										  idealQuantity: 10, favorite: false))
		}
		return productList
	}

	private func cleanRepository(listOfProducts: [Product]) {
		for product in listOfProducts {
			_ = viewModel.repository.delete(object: product)
		}
	}

}
