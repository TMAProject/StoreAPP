//
//  File.swift
//  StoreAPP
//
//  Created by Vinicius Mesquita on 01/12/20.
//

import Foundation

class CreateProductViewModel: ViewModel {

    let formFields = ProductForm.create
    let repository = ProductRepository()
    var productDTO: ProductDTO?

    public var handleDismiss: (() -> Void)?
    public var category: Category

    init(category: Category) {
        self.category = category
    }

    var numberOfSections: Int {
        return formFields.numberOfSections
    }

    @objc func cancel() {
        handleDismiss?()
    }

    @objc func save() {
        var emptyProduct = ProductDTO.empty
        emptyProduct.category = Int16(category.rawValue)
        _ = repository.add(object: productDTO ?? emptyProduct)
        handleDismiss?()
    }

    func getSectionName(at section: Int) -> String {
        return formFields.sections[section]
    }

    func numberOfRows(at section: Int) -> Int {
        let sectionName = getSectionName(at: section)
        return formFields.fields[sectionName]?.count ?? 0
    }

    func getFieldBySectionName(section: Int, at index: Int) -> String? {
        let sectionName = getSectionName(at: section)
        return formFields.fields[sectionName]?[index]
    }

}

extension CreateProductViewModel {

    public func sectionName(at index: Int) -> String {
        return formFields.sections[index]
    }

    public func numberOfRowsForSection(at index: Int) -> Int {
        let sectionName = formFields.sections[index]
        return formFields.fields[sectionName]?.count ?? 0
    }

    public func fieldName(section: Int, index: Int) -> String? {
        formFields.fields[sectionName(at: section)]![index]
    }

}

extension CreateProductViewModel: ProductFieldDelegate {
    func didUpdateTextField(text: String, field: ProductFields) {
        switch field {
        case .name:
            self.productDTO?.name = text
        case .quantity:
            self.productDTO?.quatity = Int32(text) ?? 0
        case .idealQuantity:
            self.productDTO?.idealQuantity = Int32(text) ?? 0
        }
    }
}
