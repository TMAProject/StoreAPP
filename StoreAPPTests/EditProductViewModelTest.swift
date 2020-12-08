//
//  EditProductViewModel.swift
//  StoreAPPTests
//
//  Created by Fernando de Lucas da Silva Gomes on 07/12/20.
//

import XCTest
import CoreData
@testable import StoreAPP

class EditViewModelTest: XCTestCase {

    var productMock: Product?
    var sut: EditProductViewModel?
    let formField = ProductForm.edit
    let repository = ProductRepository()

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

    override func tearDown() {
        productMock = nil
    }

    override func setUp() {
        self.productMock = createMockProduct()
        self.sut = EditProductViewModel(self.productMock!)
    }

    func test_numberOfSections_EqualToFormFields() {
        XCTAssertEqual(sut?.numberOfSections, formField.numberOfSections)
    }

    func test_ordenatedFields_EqualToMockedOrdenatedFields() {
        //given
        let ordenatedFields = sut?.ordenatedFields
        let mockedString = ["": ["\(self.productMock!.name)", "\(self.productMock!.category)"],
                            "Estoque(unidade de medida)": ["\(self.productMock!.quantity)", "\(self.productMock!.idealQuantity)"]]
        //then
        XCTAssertEqual(ordenatedFields, mockedString)
    }

    func test_sectionName_EqualToFormFields() {
        XCTAssertEqual(sut?.sectionName(at: 1), formField.sections[1])
    }

    func test_save_EqualToProductDTOName() {
        //given
        _ = sut?.save()
        let productTest = sut?.productDTO.name

        //then
        XCTAssertEqual(self.productMock?.name, productTest)
    }

    func test_numberOfRowsForSection_EqualToFormFields() {
        //guven
        let numberOfRows = sut?.numberOfRowsForSection(at: 1)

        //then
        XCTAssertEqual(formField.fields["Estoque(unidade de medida)"]?.count, numberOfRows)
    }

    func test_fieldsName_EqualToFormFields() {
        //given
        let fieldName = sut?.fieldName(section: 1, index: 0)
        let expectedName = formField.fields["Estoque(unidade de medida)"]?[0]
        //then
        XCTAssertEqual(fieldName, expectedName)
    }

    func test_FieldValues_EqualToProductMockName() {
        //given
        let fieldValue = sut?.fieldValues(section: 0, index: 0)
        //then
        XCTAssertEqual(fieldValue, productMock?.name)
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
}
