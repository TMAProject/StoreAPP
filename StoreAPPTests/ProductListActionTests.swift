//
//  ProductListActionTests.swift
//  StoreAPPTests
//
//  Created by Vinicius Mesquita on 07/12/20.
//

import XCTest
@testable import StoreAPP

class ProductListActionTests: XCTestCase {

    var sut: ProductListAction?

    func test_titleFavorite_Favoritar() {
        // given
        sut = .favorite
        // when
        let expectedTitle = "Favoritar"
        let title = sut?.title
        // then
        XCTAssertEqual(expectedTitle, title)
    }

    func test_titleUnFavorite_Desfavoritar() {
        // given
        sut = .unfavorite
        // when
        let expectedTitle = "Desfavoritar"
        let title = sut?.title
        // then
        XCTAssertEqual(expectedTitle, title)
    }

    func test_titleDelete_Deletar() {
        // given
        sut = .delete
        // when
        let expectedTitle = "Deletar"
        let title = sut?.title
        // then
        XCTAssertEqual(expectedTitle, title)
    }

    func test_colorFavorite_Favoritar() {
        // given
        sut = .favorite
        // when
        let expectedColor = UIColor.systemGreen
        let color = sut?.color
        // then
        XCTAssertEqual(expectedColor, color)
    }

    func test_colorUnFavorite_Desfavoritar() {
        // given
        sut = .unfavorite
        // when
        let expectedColor = UIColor.systemGray
        let color = sut?.color
        // then
        XCTAssertEqual(expectedColor, color)
    }

    func test_colorDelete_Deletar() {
        // given
        sut = .delete
        // when
        let expectedColor = UIColor.systemRed
        let color = sut?.color
        // then
        XCTAssertEqual(expectedColor, color)
    }

    func test_styleFavorite_Favoritar() {
        // given
        sut = .favorite
        // when
        let expectedStyle = UIContextualAction.Style.normal
        let style = sut?.style
        // then
        XCTAssertEqual(expectedStyle, style)
    }

    func test_styleUnFavorite_Desfavoritar() {
        // given
        sut = .unfavorite
        // when
        let expectedStyle = UIContextualAction.Style.normal
        let style = sut?.style
        // then
        XCTAssertEqual(expectedStyle, style)
    }

    func test_styleDelete_Deletar() {
        // given
        sut = .delete
        // when
        let expectedStyle = UIContextualAction.Style.destructive
        let style = sut?.style
        // then
        XCTAssertEqual(expectedStyle, style)
    }

}
