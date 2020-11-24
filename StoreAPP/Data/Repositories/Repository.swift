//
//  Repository.swift
//  StoreAPP
//
//  Created by Academy on 23/11/20.
//

import Foundation

protocol Repository {
    associatedtype ObjectV
    associatedtype Object

    func getAll() -> [Object]
    func get(object: Object) -> Object?
    func add(object: ObjectV) -> Object?
    func delete(object: Object) -> Bool
}

extension Repository {

    func get(object: Object) -> Object? {
        return nil
    }
}
