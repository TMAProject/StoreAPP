//
//  CreateProduct.swift
//  StoreAPP
//
//  Created by José João Silva Nunes Alves on 25/11/20.
//
import UIKit

protocol ProductFieldDelegate: class {
    func didUpdateTextField(text: String, field: ProductFields)
}

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
            return ["": ["Nome"], "Estoque": ["Quantidade", "Quantidade ideal"]]
        case .edit:
            return ["": ["Nome"], "Estoque": ["Quantidade", "Quantidade ideal"]]
        }
    }
}

enum ProductSections {
    case info
    case estoque
}

enum ProductFields: String{
    case name = "Nome"
    case quantity = "Quantidade"
    case idealQuantity = "Quantidade ideal"
    
    var keyboardType : UIKeyboardType {
        switch self {
        case .name:
            return UIKeyboardType.default
        case .quantity:
            return UIKeyboardType.numberPad
        case .idealQuantity:
            return UIKeyboardType.numberPad
        }
    }
}
