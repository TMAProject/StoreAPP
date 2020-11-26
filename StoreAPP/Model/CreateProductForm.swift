//
//  CreateProduct.swift
//  StoreAPP
//
//  Created by José João Silva Nunes Alves on 25/11/20.
//

import Foundation

struct CreateProductForm {
    let numberOfsections: Int = 2
    let sections: [String] = ["", "ESTOQUE"]
    let fields: [String: [String]] = ["": ["Titulo", "Descrição"], "ESTOQUE": ["Quantidade", "Quantidade ideal"]]
}
