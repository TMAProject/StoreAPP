//
//  Category.swift
//  StoreAPP
//
//  Created by Alley Pereira on 23/11/20.
//

import UIKit

enum Category: Int, CaseIterable {
    case drinks
    case candies
    case dry
    case pickled
    case spices
    case vegetables
    case fruit
    case others

    var color: UIColor {
        switch self {
        case .drinks:
            return UIColor.systemOrange
        case .candies:
            return UIColor.systemPink
        case .dry:
            return UIColor.init(named: "othersColor")!
        case .pickled:
            return UIColor.systemTeal
        case .spices:
            return UIColor.systemYellow
        case .vegetables:
            return UIColor.systemGreen
        case .others:
            return UIColor.systemIndigo
        case .fruit:
            return UIColor.systemRed
        }
    }
    var icon: UIImage {
        switch self {
        case .drinks:
            return UIImage.init(named: "drinks")!
        case .candies:
            return UIImage.init(named: "candies")!
        case .dry:
            return UIImage.init(named: "dry")!
        case .pickled:
            return UIImage.init(named: "pickled")!
        case .spices:
            return UIImage.init(named: "spices")!
        case .vegetables:
            return UIImage.init(named: "vegetables")!
        case .fruit:
            return UIImage.init(named: "fruit")!
        case .others:
            return UIImage.init(named: "others")!
        }
    }
    
    var title: String {
        switch self {
        case .drinks:
            return "Bebidas"
        case .candies:
            return "Doces"
        case .dry:
            return "Secos"
        case .pickled:
            return "Conserva"
        case .spices:
            return "Temperos"
        case .vegetables:
            return "Vegetais"
        case .fruit:
            return "Frutas"
        case .others:
            return "Outros"
        }
    }
}
