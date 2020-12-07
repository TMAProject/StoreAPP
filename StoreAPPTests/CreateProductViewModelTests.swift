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
    let formField = ProductForm.create

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
        sut?.productDTO = productDTO!
        // when
        sut?.save()
        product = sut?.repository.getAll().first
        // then
        XCTAssertEqual(productDTO?.name, product?.name)
    }

    func test_save_EmptyProduct() {
        // given -> nil
        // when
        sut?.save()
        product = sut?.repository.getAll().first
        // then
        XCTAssertEqual(product?.name, "Novo Produto")
    }

    func test_cancel_EmptyProduct() {
        // given -> nil
        sut?.handleDismiss = { print("dismiss") }
        // when
        sut?.cancel()
        // then
        XCTAssertNotNil(sut?.handleDismiss)
    }

    func test_numberOfRowsForSection_EqualToFormFields() {
         //guven
         let numberOfRows = sut?.numberOfRowsForSection(at: 1)

         //then
         XCTAssertEqual(formField.fields["Estoque"]?.count, numberOfRows)
     }

     func test_fieldsName_EqualToFormFields() {
         //given
         let fieldName = sut?.fieldName(section: 1, index: 0)
         let expectedName = formField.fields["Estoque"]?[0]
         //then
         XCTAssertEqual(fieldName, expectedName)
     }

    func test_sectionName_EqualToFormFields() {
           XCTAssertEqual(sut?.sectionName(at: 1), formField.sections[1])
    }
    
     func test_didUpdateTextField_EqualToProductDTOName() {
         //given
         _ = sut?.didUpdateTextField(text: "Teste", field: ProductFields.name)
         //then
        XCTAssertEqual(sut?.productDTO.name, "Teste")
     }

     func test_didUpdateTextField_EqualToProductDTOQuantity() {
         //given
         _ = sut?.didUpdateTextField(text: "10", field: ProductFields.quantity)
         //then
         XCTAssertEqual(sut?.productDTO.quatity, 10)
     }

     func test_didUpdateTextField_EqualToProductDTOIdealQuantity() {
         //given
         _ = sut?.didUpdateTextField(text: "20", field: ProductFields.idealQuantity)
         //then
         XCTAssertEqual(sut?.productDTO.idealQuantity, 20)
     }

     func test_didUpdateTextField_IdealQuantityEqualToZero() {
         //given
         _ = sut?.didUpdateTextField(text: "Teste", field: ProductFields.idealQuantity)
         //then
         XCTAssertEqual(sut?.productDTO.idealQuantity, 0)
     }

     func test_didUpdateTextField_QuantityEqualToZero() {
         //given
         _ = sut?.didUpdateTextField(text: "Teste", field: ProductFields.quantity)
         //then
         XCTAssertEqual(sut?.productDTO.quatity, 0)
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
