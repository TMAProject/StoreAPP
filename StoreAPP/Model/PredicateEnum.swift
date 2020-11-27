//
//  PredicateEnum.swift
//  StoreAPP
//
//  Created by Fernando de Lucas da Silva Gomes on 27/11/20.
//

import Foundation

enum ProductPredicate: PredicateProtocol {

    case getFromId(identifier: String)
    case getFromCategory(category: Int)
    case getFavorite

    var predicate: NSPredicate {

        switch self {

        case .getFromId(let identifier):
            return NSPredicate(format: "id = %@", identifier)

        case .getFromCategory(let category):
            return NSPredicate(format: "category = %@", "\(category)")

        case .getFavorite:
            return NSPredicate(format: "favorite = %@", NSNumber(value: true))

        }
    }
}

protocol PredicateProtocol {}
