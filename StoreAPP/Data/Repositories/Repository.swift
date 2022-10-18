//
//  Repository.swift
//  StoreAPP
//
//  Created by Academy on 23/11/20.
//

import Foundation

protocol Repository {
    associatedtype ObjectDTO
    associatedtype Object

    func getAll() -> [Object]
    func get(object: Object) -> Object?
    func add(object: ObjectDTO) -> Object?
    func delete(object: Object) -> Object?
}
