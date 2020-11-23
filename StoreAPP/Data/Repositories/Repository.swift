//
//  Repository.swift
//  StoreAPP
//
//  Created by Academy on 23/11/20.
//

import Foundation

protocol Repository {
    associatedtype Object
    func getAll() -> [Object]
    func get(id: Int) -> Object?
    func add(object: Object) -> Bool
    func update(object: Object) -> Bool
    func delete(object: Object) -> Bool
}

extension Repository {
    
    func get(id: Int) -> Object? {
        return nil
    }
    
    func update(object: Object) -> Bool {
        return false
    }
}
