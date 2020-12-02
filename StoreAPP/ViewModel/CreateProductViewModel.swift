//
//  File.swift
//  StoreAPP
//
//  Created by Vinicius Mesquita on 01/12/20.
//

import Foundation

class CreateProductViewModel: ViewModel {

    private let formFields = CreateProductForm()
    private let repository = ProductRepository()
    private var product: ProductDTO?

    public var handleDismiss: (() -> Void)?
    public var cells: [FieldTableViewCell] = []

    public var category: Category

    init(category: Category) {
        self.category = category
    }

    var numberOfSections: Int {
        return formFields.numberOfsections
    }

    @objc func cancel() {
        // Coordinator code comes here.
        handleDismiss?()
    }

    @objc func save() {
        product = getDataFromField()
        guard let product = product else { fatalError("This product don't exist") }
        if let savedProduct = repository.add(object: product) {
            print("Produto: \(savedProduct.name) salvo.")
        }
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

    private func getDataFromField() -> ProductDTO {
        var name: String = ""
        var quantity: Int32 = 0
        var idealQuantity: Int32 = 0

        for cell in cells {
            switch cell.label.text {
            case "Nome":
                name = cell.textField.text ?? ""
            case "Quantidade":
                quantity = Int32(cell.textField.text!) ?? 0
            case "Quantidade ideal":
                idealQuantity = Int32(cell.textField.text!) ?? 0
            default:
                break
            }
        }
        return ProductDTO(name: name, category: Int16(category.rawValue),
                          quatity: quantity,
                          idealQuantity: idealQuantity,
                          favorite: false)
    }

    func bindCell(cell: FieldTableViewCell?) {
        guard let fieldTableViewCell = cell else { return }
        cells.append(fieldTableViewCell)
    }
}
