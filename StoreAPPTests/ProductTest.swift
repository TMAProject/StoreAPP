//
//  ProductTest.swift
//  StoreAPPTests
//
//  Created by Alley Pereira on 08/12/20.
//

import XCTest
import CoreData
@testable import StoreAPP

class ProductTest: XCTestCase {

	func testFetchRequest_productFetchRequest() {
		//given
		let expectedEntityName = "Product"

		//when
		let sut: NSFetchRequest<Product> = Product.fetchRequest()

		//then
		XCTAssertEqual(sut.entityName, expectedEntityName)
	}
}
