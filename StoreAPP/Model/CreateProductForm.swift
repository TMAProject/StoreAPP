//
//  CreateProduct.swift
//  StoreAPP
//
//  Created by José João Silva Nunes Alves on 25/11/20.
//

import Foundation

enum ProductForm {
    case create
    case edit

    var sections: [String] {
        switch self {
        case .create:
            return ["", "Estoque"]
        case .edit:
            return ["", "Estoque"]
        }
    }

    var numberOfSections: Int {
        switch self {
        case .create:
            return 2
        case .edit:
            return 2
        }
    }

    var fields: [String: [String]] {
        switch self {
        case .create:
            return ["": ["Descrição", "Categoria"], "Estoque": ["Quantidade", "Quantidade ideal"]]
        case .edit:
            return ["": ["Descrição", "Categoria"], "Estoque": ["Quantidade", "Quantidade ideal"]]
        }
    }
}

enum ProductSections {
    case info
    case estoque
}

enum ProductFields: String {
    case description = "Descrição"
    case category = "Categoria"
    case quantity = "Quantidade"
    case idealQuantity = "Quantidade ideal"
}
