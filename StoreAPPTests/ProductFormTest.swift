//
//  ProductFormTest.swift
//  StoreAPPTests
//
//  Created by Fernando de Lucas da Silva Gomes on 07/12/20.
//

import XCTest
@testable import StoreAPP

class ProductFormTest: XCTestCase {

    let productForm = ProductForm.self
    let productFields = ProductFields.self

    func test_section_CreateSectionEqualToGivenArray() {
        let createArray = productForm.create.sections
        XCTAssertEqual(["", "Estoque(unidade de medida)"], createArray)
    }

    func test_section_EditSectionEqualToGivenArray() {
        let createArray = productForm.edit.sections
        XCTAssertEqual(["", "Estoque(unidade de medida)"], createArray)
    }

    func test_section_EditNumberOfSectionsEqualToGivenValue() {
        let numberOfSections = productForm.edit.numberOfSections
        XCTAssertEqual(2, numberOfSections)
    }

    func test_section_CreateNumberOfSectionsEqualToGivenValue() {
        let numberOfSections = productForm.create.numberOfSections
        XCTAssertEqual(2, numberOfSections)
    }

    func test_section_CreateFieldsEqualToGivenValue() {
		let expectedDictionary = ["": ["Nome"], "Estoque(unidade de medida)": ["Quantidade", "Quantidade ideal"]]
        let dictionaryField = productForm.create.fields
        XCTAssertEqual(expectedDictionary, dictionaryField)
    }

    func test_section_EditFieldsEqualToGivenValue() {
		let expectedDictionary = ["": ["Nome"], "Estoque(unidade de medida)": ["Quantidade", "Quantidade ideal"]]
        let dictionaryField = productForm.edit.fields
        XCTAssertEqual(expectedDictionary, dictionaryField)
    }

    func test_keyBoardType_KeyboardTypeForNameEqualToGivenKeyboardType() {
        let keyboardType = productFields.name.keyboardType
        let givenKeyboardType = UIKeyboardType.default
        XCTAssertEqual(keyboardType, givenKeyboardType)
    }

    func test_keyBoardType_KeyboardTypeForQuantityEqualToGivenKeyboardType() {
        let keyboardType = productFields.quantity.keyboardType
        let givenKeyboardType = UIKeyboardType.numberPad
        XCTAssertEqual(keyboardType, givenKeyboardType)
    }

    func test_keyBoardType_KeyboardTypeForIdealQuantityEqualToGivenKeyboardType() {
        let keyboardType = productFields.idealQuantity.keyboardType
        let givenKeyboardType = UIKeyboardType.numberPad
        XCTAssertEqual(keyboardType, givenKeyboardType)
    }
}
