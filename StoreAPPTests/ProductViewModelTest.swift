//
//  ProductViewModelTests.swift
//  StoreAPPTests
//
//  Created by José João Silva Nunes Alves on 30/11/20.
//

import XCTest
import CoreData
@testable import StoreAPP

class ProductViewModelTest: XCTestCase {

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

    func testInitWithProduct_createsProductViewModel() {
        let product: Product = createMockProduct()

        XCTAssertNotNil(ProductViewModel(product))
    }

    func testGetCategory_productViewModelCategoryEqualProductCategorySended() {
        let product: Product = createMockProduct()
        let productViewModel = ProductViewModel(product)

        XCTAssertEqual(productViewModel.category, product.category)
    }

    func testGetFavorite_productViewModelFavoriteEqualProductFavoriteSended() {
        let product: Product = createMockProduct()
        let productViewModel = ProductViewModel(product)

        XCTAssertEqual(productViewModel.favorite, product.favorite)
    }
}
