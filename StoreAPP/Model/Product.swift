//
//  Product.swift
//  StoreAPP
//
//  Created by Fernando de Lucas da Silva Gomes on 19/11/20.
//

import Foundation
import CoreData

@objc(Product)
public class Product: NSManagedObject{

}

extension Product{

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var name: String
    @NSManaged public var category: Int16
    @NSManaged public var quantity: Int32
    @NSManaged public var idealQuantity: Int32
    @NSManaged public var favorite: Bool

}

enum Schema{
    enum Product: String{
        case name
    }
}
