//
//  ContextualActionsTests.swift
//  StoreAPPTests
//
//  Created by Vinicius Mesquita on 07/12/20.
//

import XCTest
@testable import StoreAPP

class ContextualActionsTests: XCTestCase {

    var sut: ContextualAction<ProductListAction>?
    private var helper = ContextualHelperDelegate()

    override func setUp() {
        sut = ContextualAction<ProductListAction>(helper, actions: [], index: 0)
    }

    func test_addContextuals_favorite() {
        // given
        let contextuals: [ProductListAction] = [.favorite]

        // when
        sut?.addContextuals(actions: contextuals)

        // then
        XCTAssertEqual(sut?.contextuals.count, 1)
    }

    func test_setup_contextualAction() {
        // given
        sut?.addContextuals(actions: [.favorite, .delete, .unfavorite])
        // when
        let contextualAction = sut?.setup()
        // then
        XCTAssertNotNil(contextualAction)
    }

    func test_delegate_contextualAction() {
        // given
        sut?.addContextuals(actions: [.favorite, .delete, .unfavorite])
        // when
        sut?.delegate?.didPerform(action: ProductListAction.delete, index: 0)
        // then
        XCTAssertNotNil(helper.action)
    }

}

private class ContextualHelperDelegate: SwipeActionDelegate {
    var action: SwipeAction?

    func didPerform(action: SwipeAction, index: Int) {
        self.action = action
    }
}
