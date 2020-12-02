//
//  RepositoryTest.swift
//  StoreAPPTests
//
//  Created by Academy on 24/11/20.
//

import XCTest
@testable import StoreAPP

class RepositoryTest: XCTestCase {

    var repository: ProductRepository!

    override func setUp() {
        repository = ProductRepository()
    }

    func test_add_true() {
        // given
        let product = ProductDTO(name: "b", category: 0, quatity: 0, idealQuantity: 0, favorite: true)

        // when
        let savedProduct = repository.add(object: product)

        // then
        let fetchedProduct = repository.get(object: savedProduct!)
		XCTAssertEqual(fetchedProduct?.name, savedProduct?.name) // estava comparando valores iguais com itens diferentes
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }//x-coredata://B068BF7B-9D6D-46FD-81A0-D61C014F6496/Product/p9

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
