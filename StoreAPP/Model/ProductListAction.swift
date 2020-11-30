//
//  ProductListAction.swift
//  StoreAPP
//
//  Created by Academy on 30/11/20.
//

import UIKit

enum ProductListAction: SwipeAction {
    case favorite
    case delete

    var title: String {
        switch self {
        case .favorite: return "Favorite"
        case .delete: return "Delete"
        }
    }

    var color: UIColor {
        switch self {
        case .favorite: return UIColor.black
        case .delete: return UIColor.black
        }
    }

    var style: UIContextualAction.Style {
        switch self {
        case .favorite: return UIContextualAction.Style.normal
        case .delete: return UIContextualAction.Style.destructive
        }
    }
}
