//
//  ProductListAction.swift
//  StoreAPP
//
//  Created by Academy on 30/11/20.
//

import UIKit

enum ProductListAction: SwipeAction {
    case favorite
    case unfavorite
    case delete

    var title: String {
        switch self {
        case .favorite: return "Favorite"
        case .delete: return "Delete"
        case .unfavorite: return "Unfavorite"
        }
    }

    var color: UIColor {
        switch self {
        case .favorite: return UIColor.systemGreen
        case .delete: return UIColor.red
        case .unfavorite: return UIColor.systemGray
        }
    }

    var style: UIContextualAction.Style {
        switch self {
        case .favorite: return UIContextualAction.Style.normal
        case .delete: return UIContextualAction.Style.destructive
        case .unfavorite: return UIContextualAction.Style.normal
        }
    }
}
