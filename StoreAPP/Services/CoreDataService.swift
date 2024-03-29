//
//  CoreDataService.swift
//  StoreAPP
//
//  Created by Fernando de Lucas da Silva Gomes on 19/11/20.
//

import UIKit
import CoreData

extension NSManagedObject {
    static var entityName: String {
        return String(describing: self)
    }
}

class CoreDataService<T: NSManagedObject> {

    let persistentStore: NSPersistentContainer = {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let container = appDelegate?.persistentContainer
        guard let persistentContainer = container else { fatalError() }
        return persistentContainer
    }()

    func new() -> T? {
        guard let entity = NSEntityDescription.entity(forEntityName: T.entityName, in: persistentStore.viewContext)
        else { return nil }
        return T(entity: entity, insertInto: persistentStore.viewContext)
    }

    func fetchAll() -> [T]? {
        let context = persistentStore.viewContext
        let productFetch = NSFetchRequest<T>(entityName: T.entityName)
        productFetch.sortDescriptors = [NSSortDescriptor(key: Schema.Field.name.rawValue, ascending: true)]
        do {
            let products = try context.fetch(productFetch)
            return products
        } catch let error as NSError {
            print(error)
            return nil
        }
    }

    func save() -> Bool {
        let context = persistentStore.viewContext
        do {
            try context.save()
            return true
        } catch {
            context.handleSavingError(error, info: "Saving with error")
            return false
        }
    }

    func retrieve(predicate: NSPredicate) -> [T]? {
        let context = persistentStore.viewContext
        let productFetch = NSFetchRequest<T>(entityName: T.entityName)
        productFetch.sortDescriptors = [NSSortDescriptor(key: Schema.Field.name.rawValue, ascending: true)]
        productFetch.predicate  = predicate
        do {
            let objects = try context.fetch(productFetch)
            return objects
        } catch let error as NSError {
            print(error)
            return nil
        }
    }

    func delete(object: T) -> T? {
        let context = persistentStore.viewContext
        context.delete(object)
        do {
            try context.save()
            return object
        } catch let error as NSError {
            context.handleSavingError(error, info: "deleting product")
            return nil
        }
    }
}

extension NSManagedObjectContext {
    func handleSavingError(_ error: Error, info: String) {
        print("Saving error: \(error) when \(info)")
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.delegate?.window,
                  let viewController = window?.rootViewController else { return }
            let message = "Failed to save the contex \(info)"
            // Append message to existing alert if present
            if let currentAlert = viewController.presentedViewController as? UIAlertController {
                currentAlert.message = (currentAlert.message ?? "") + "\n\n\(message)"
                return
            }
            // Otherwise present a new alert
            let alert = UIAlertController(title: "Core Data Saving Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            viewController.present(alert, animated: true)
        }
    }

}
