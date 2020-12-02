//
//  ProductListViewModelTests.swift
//  StoreAPPTests
//
//  Created by Academy on 30/11/20.
//

import XCTest
import CoreData
@testable import StoreAPP

class ProductListViewModelTests: XCTestCase {

    var viewModel: ProductListViewModel!
    var service: CoreDataService<Product>!
    var listOfProducts: [Product]!

    override func setUp() {
        viewModel = ProductListViewModel(category: .candies)
        service = CoreDataService<Product>()
        listOfProducts = []
    }

    override func tearDown() {
        cleanRepository(listOfProducts: listOfProducts)
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
    }

    func test_favoriteFromCell_Nil() {
        // given -> nil
        // when
        let favoritedFromCell = viewModel.favoriteFromCell(at: 0)
        // then
        XCTAssertNil(favoritedFromCell)
    }

    // Mock Functions.
    private func createMockProducts() -> [ProductViewModel] {
        let product = createMockProduct()
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
