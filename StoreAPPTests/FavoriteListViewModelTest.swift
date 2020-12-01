//
//  FavoriteListViewModelTest.swift
//  StoreAPPTests
//
//  Created by José João Silva Nunes Alves on 30/11/20.
//

import XCTest
import CoreData
@testable import StoreAPP
// swiftlint:disable line_length

class FavoriteListViewModelTest: XCTestCase {

    var produtList: [Product] = [Product]()
    var sut: FavoriteListViewModel?
    let repository: ProductRepository = ProductRepository()

    override func setUp() {
        self.createMockFavoriteList()
        self.sut = FavoriteListViewModel()
        self.sut?.getFavorites()
    }

    override func tearDown() {
        self.cleanRepository()
        self.sut = nil
    }

    func test_productForCell_productViewModel() {
        let index = Int.random(in: 0..<produtList.count)
        XCTAssertEqual(sut?.favoritesList[index], sut?.productForCell(at: index))
    }

    func test_productForCell_nil() {
        let index = sut!.favoritesList.count
        XCTAssertNil(sut?.productForCell(at: index))
    }

    func test_unfavoriteFromCell_ProductViewModel() {
        let index = Int.random(in: 0..<produtList.count)
        let unfavoriteProduct = sut?.favoritesList[index]
        let unfavoriteFromCell = sut?.unfavoriteFromCell(at: index)
        XCTAssertEqual(unfavoriteProduct, unfavoriteFromCell)
    }

    func test_unfavoriteFromCell_propertieFavoriteIsFalse() {
        let index = Int.random(in: 0..<produtList.count)
        let unfavoriteFromCell = sut?.unfavoriteFromCell(at: index)
        XCTAssertEqual(unfavoriteFromCell?.favorite, false)
    }

    func test_unfavoriteFromCell_nil() {
        let index = sut!.favoritesList.count
        XCTAssertNil(sut?.unfavoriteFromCell(at: index))
    }

    func test_deleteFromCell_product() {
        let index = Int.random(in: 0..<produtList.count)
        let deletedProduct = sut?.favoritesList[index]
        let deletedFromCell = sut?.deleteFromCell(at: index)!
        XCTAssertEqual(deletedProduct, ProductViewModel(deletedFromCell!))
    }

    func test_deleteFromCell_nil() {
        let index = sut!.favoritesList.count
        XCTAssertNil(sut?.deleteFromCell(at: index))
    }

    private func createMockProductDTO() -> ProductDTO {
        let productDTO: ProductDTO = ProductDTO(name: "productName", category: 1, quatity: 15, idealQuantity: 10, favorite: true)
        return productDTO
    }

    private func createMockProductsDTO() -> [ProductDTO] {
        let product = self.createMockProductDTO()
        let productList: [ProductDTO] = Array(repeating: product, count: 10)
        return productList
    }

    private func createMockFavoriteList() {
        for product in self.createMockProductsDTO() {
            self.produtList.append(repository.add(object: product)!)
        }
    }

    private func cleanRepository() {
        for product in produtList {
            _ = repository.delete(object: product)
        }
    }
}
