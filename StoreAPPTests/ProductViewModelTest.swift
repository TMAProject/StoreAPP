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

    var productMock: Product?
    var sut: ProductViewModel?

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
        self.productMock = createMockProduct()
        self.sut = ProductViewModel(self.productMock!)
    }

    override func tearDown() {
        self.productMock = nil
        self.sut = nil
    }

    func test_init_ProductViewModel() {
        XCTAssertNotNil(ProductViewModel(self.productMock!))
    }

    func test_getName_productViewModelNameEqualProductNameSended() {
        XCTAssertEqual(sut!.name, self.productMock!.name)
    }

    func test_getDescription_productViewModelDescriptionEqualProductDescriptionSended() {
        XCTAssertEqual(sut!.description, "Qtd: \(self.productMock!.quantity) / \(self.productMock!.idealQuantity)")
    }

    func test_getCategory_productViewModelCategoryEqualProductCategorySended() {
        XCTAssertEqual(sut!.category, self.productMock!.category)
    }

    func test_getQuantity_productViewModelQuantityEqualProductQuantitySended() {
        XCTAssertEqual(sut!.quantity, self.productMock!.quantity)
    }

    func test_getIdealQuantity_productViewModelIdealQuantityEqualProductIdealQuantitySended() {
        XCTAssertEqual(sut!.idealQuantity, self.productMock!.idealQuantity)
    }

    func test_getFavorite_productViewModelFavoriteEqualProductFavoriteSended() {
        XCTAssertEqual(sut!.favorite, self.productMock!.favorite)
    }
}
