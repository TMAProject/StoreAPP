//
//  CreateProductViewModelTests.swift
//  StoreAPPTests
//
//  Created by Vinicius Mesquita on 07/12/20.
//

import XCTest
@testable import StoreAPP

class CreateProductViewModelTests: XCTestCase {

    var sut: CreateProductViewModel?
    var productDTO: ProductDTO?
    var product: Product?

    override func setUp() {
        sut = CreateProductViewModel(category: Category.candies)
        productDTO = createProductDTOMock()
    }

    override func tearDown() {
        self.cleanRepository()
        self.sut = nil
    }

    func test_numberOfSections_EqualToFormField() {
        // given
        XCTAssertEqual(sut?.formFields.numberOfSections, sut?.numberOfSections)
    }

    func test_save_SavedProduct() {
        // given
        sut?.product = productDTO
        // when
        sut?.save()
        let savedProduct = sut?.repository.getAll().first
        // then
        XCTAssertEqual(productDTO?.name, savedProduct?.name)
    }

    // Mock Functions
    private func createProductDTOMock() -> ProductDTO {
        ProductDTO(name: "ProductFromCreateProductViewModelTests",
                   category: 0,
                   quatity: 0,
                   idealQuantity: 0,
                   favorite: false)
    }

    private func cleanRepository() {
        _ = sut?.repository.delete(object: product ?? Product())
    }
}
