//
//  ContextualAction.swift
//  StoreAPP
//
//  Created by Vinicius on 30/11/20.
//

import UIKit

protocol SwipeActionDelegate: class {
    func didPerform(action: SwipeAction, index: Int)
}

protocol SwipeAction {

    var color: UIColor { get }
    var title: String { get }
    var style: UIContextualAction.Style { get }

}

class ContextualAction<Action: SwipeAction> {

    private var contextualAction: UIContextualAction?
    private var handler: UIContextualAction.Handler?

    private var actions: [Action]!
    private var contextuals: [UIContextualAction] = []
    private let indexRow: Int
    weak var delegate: SwipeActionDelegate?

    init(delegate: SwipeActionDelegate, actions: [Action], index: Int) {
        self.delegate = delegate
        self.indexRow = index
        self.addContextuals(actions: actions)
    }

    private func addContextuals(actions: [Action]) {
        for action in actions {
            self.handler = { _, _, _ in self.delegate?.didPerform(action: action, index: self.indexRow) }
            let contextualAction = UIContextualAction(style: action.style, title: action.title, handler: handler!)
            contextuals.append(contextualAction)
        }
    }

    public func setup() -> UISwipeActionsConfiguration? {
        let configuration = UISwipeActionsConfiguration(actions: contextuals)
        contextuals = []
        return configuration
    }

}
