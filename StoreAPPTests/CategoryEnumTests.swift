//
//  CategoryEnumTests.swift
//  StoreAPPTests
//
//  Created by Alley Pereira on 30/11/20.
//

import XCTest
@testable import StoreAPP

class CategoryEnumTests: XCTestCase {
	// MARK: - test colors
	func testColor_category_caseOneAssociatedColor() {
		//dado determinado valor, e um valor esperado apos a operacao
		let sut = Category.drinks
		let expectedColor = UIColor.systemOrange

		//quando determinada acao ou operacao acontece
		let resultColor = sut.color

		//o valor que resulta da operacao tem que ser igual ao esperado
		XCTAssertEqual(resultColor, expectedColor)
	}
	func testColor_category_caseTwoAssociatedColor() {
		let sut = Category.candies
		let expectedColor = UIColor.systemPink
		let resultColor = sut.color

		XCTAssertEqual(resultColor, expectedColor)
	}

	func testColor_category_caseThreeAssociatedColor() {
		let sut = Category.dry
		let expectedColor = UIColor(named: "othersColor")
		let resultColor = sut.color

		XCTAssertEqual(resultColor, expectedColor)
	}

	func testColor_category_caseFourAssociatedColor() {
		//given
		let sut = Category.pickled
		let expectedColor = UIColor.systemTeal

		//when
		let resultColor = sut.color

		//then
		XCTAssertEqual(resultColor, expectedColor)

	}

	func testColor_category_caseFiveAssociatedColor() {
		let sut = Category.spices
		let expectedColor = UIColor.systemYellow
		let resultColor = sut.color

		XCTAssertEqual(resultColor, expectedColor)
	}

	func testColor_category_caseSixAssociatedColor() {
		let sut = Category.vegetables
		let expectedColor = UIColor.systemGreen
		let resultColor = sut.color

		XCTAssertEqual(resultColor, expectedColor)
	}

	func testColor_category_caseSevenAssociatedColor() {
		let sut = Category.others
		let expectedColor = UIColor.systemIndigo
		let resultColor = sut.color

		XCTAssertEqual(resultColor, expectedColor)
	}

	func testColor_category_caseEightAssociatedColor() {
		let sut = Category.fruit
		let expectedColor = UIColor.systemRed
		let resultColor = sut.color

		XCTAssertEqual(resultColor, expectedColor)
	}

	override func setUpWithError() throws {
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}

	override func tearDownWithError() throws {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
	}

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
