//
//  EditProductViewModel.swift
//  StoreAPP
//
//  Created by Fernando de Lucas da Silva Gomes on 01/12/20.
//

import Foundation

class EditProductViewModel: ViewModel {

    let product: Product
    private let formFields: ProductForm = ProductForm.edit
    let repository = ProductRepository()
    var productDTO: ProductDTO
    var handleDismiss: (() -> Void)?

    init(_ product: Product) {
        self.product = product
        self.productDTO = ProductDTO(product: product)
    }
}

extension EditProductViewModel {
    var ordenatedFields: [String: [String]] {
        return ["": ["\(self.product.name)", "\(self.product.category)"],
                "Estoque": ["\(self.product.quantity)", "\(self.product.idealQuantity)"]]
    }

    var numberOfSections: Int {
        return formFields.numberOfSections
    }

    @objc public func save() {
        self.product.name = self.productDTO.name
        self.product.category = self.productDTO.category
        self.product.quantity = self.productDTO.quatity
        self.product.idealQuantity = self.productDTO.idealQuantity
        self.product.favorite = self.productDTO.favorite
        _ = repository.service.save()
        handleDismiss?()
    }

    public func sectionName(at index: Int) -> String {
        return formFields.sections[index]
    }

    public func numberOfRowsForSection(at index: Int) -> Int {
        let sectionName = formFields.sections[index]
        return formFields.fields[sectionName]?.count ?? 0
    }

    public func fieldName(section: Int, index: Int) -> String {
        guard let fieldName = formFields.fields[sectionName(at: section)]?[index] else {
            return " "
        }
        return fieldName
    }

    public func fieldValues(section: Int, index: Int) -> String {
        guard let fieldValue = ordenatedFields[sectionName(at: section)]?[index] else {
            return " "
        }
        return fieldValue
    }

}

protocol FieldDelegate: class {
    func updateTextField(text: String, identifier: ProductFields)
}

extension EditProductViewModel: FieldDelegate {
    func updateTextField(text: String, identifier: ProductFields) {
        switch identifier {
        case .description:
            self.productDTO.name = text
        case .quantity:
            self.productDTO.quatity = Int32(text) ?? 0
        case .idealQuantity:
            self.productDTO.idealQuantity = Int32(text) ?? 0
        }
    }

}
