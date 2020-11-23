//
//  CoreDataService.swift
//  StoreAPP
//
//  Created by Fernando de Lucas da Silva Gomes on 19/11/20.
//

import UIKit
import CoreData

class CoreDataService {
    let persistentStore: NSPersistentContainer = {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let container = appDelegate?.persistentContainer
        guard let persistentContainer = container else {fatalError()}
        return persistentContainer
    }()
    func fetchAllProduct() -> [NSManagedObject]? {
        let context = persistentStore.viewContext
        let productFetch = NSFetchRequest<Product>(entityName: "Product")
        productFetch.sortDescriptors = [NSSortDescriptor(key: Schema.Product.name.rawValue, ascending: true)]
        do {
            let products = try context.fetch(productFetch)
            return products
        } catch let error as NSError {
            print(error)
            return nil
        }
    }

    func save() {
        let context = persistentStore.viewContext
        context.perform {
            context.save(with: "saving product")
        }
    }
    
    func retrieveProduct(from: Product) -> Product?{
        let context = persistentStore.viewContext
        
        let productFetch = NSFetchRequest<Product>(entityName: "Product")
        productFetch.predicate  = NSPredicate(format: "productName = %@", from.name)
        
        do{
            let managedObject = try context.fetch(productFetch)
            return managedObject[0]
            
        } catch let error as NSError{
            print (error)
            return nil
        }
    }
    
    // adicionado shouldSave para casos em que voce deseja deletar mas nao ira salvar agora o context.
    func deleteProduct(product: Product, shouldSave: Bool){
        let context = persistentStore.viewContext
        context.perform {
            context.delete(product)
            if shouldSave{
                context.save(with: "deleting product")
            }
        }
    }
}

extension NSManagedObjectContext {
    func handleSavingError(_ error: Error, info: String) {
        print("Saving error: \(error) when \(info)")

        DispatchQueue.main.async {
            guard let window = UIApplication.shared.delegate?.window,
                let viewController = window?.rootViewController else { return }
            let message = "Failed to save the context."
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

    func save(with information: String) {
        do {
            try save()
        } catch {
            handleSavingError(error, info: information)
        }
    }

}
