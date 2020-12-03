//
//  CoreDataServiceTest.swift
//  StoreAPPTests
//
//  Created by Fernando de Lucas da Silva Gomes on 30/11/20.
//

import XCTest
import CoreData
@testable import StoreAPP

class TestCoreDataService: XCTestCase {

    var dataService = CoreDataService<Product>()

    func test_new_equalToEntityProduct() {
        //given
        let product = dataService.new()

        //when
        let entity = NSEntityDescription.entity(forEntityName: "Product", in: dataService.persistentStore.viewContext)

        //then
        XCTAssertEqual(product?.entity, entity)
    }

    func test_fetchAll_notNil() {
        //given
        let newProduct = dataService.new()
        newProduct?.setValue("Novo", forKey: "name")

        //when
        let products = dataService.fetchAll()

        //then
        XCTAssertNotNil(products?.contains(newProduct!))
    }

    func test_save_true() {
       // when
        let save = dataService.save()

        //then
        XCTAssertTrue(save)
    }

    func test_retrieve_notNil() {
        //given
        let newProduct = dataService.new()
        newProduct?.setValue("Arriz", forKey: "name")

        //when
        let retrieveProduct = dataService.retrieve(predicate: NSPredicate(format: "name = %@", "Arroz"))
        let contains = retrieveProduct?.contains(newProduct!)

        //then
        XCTAssertNotNil(contains)
    }

    func test_delete_NotNil() {
        //given
        let newProduct = dataService.new()
        newProduct?.setValue("Feijão", forKey: "name")

        //when
        let returnFromDelete = dataService.delete(object: newProduct!)

        //then
        XCTAssertNotNil(returnFromDelete)
    }

    override func tearDown() {
        self.cleanCoreData()
    }

    private func cleanCoreData() {
        let produtList = dataService.fetchAll()
        for product in produtList! {
            _ = dataService.delete(object: product)
        }
    }
}
