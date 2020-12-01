//
//  File.swift
//  StoreAPP
//
//  Created by Vinicius Mesquita on 01/12/20.
//

import Foundation

class CreateProductViewModel: ViewModel {

    private let formFields = CreateProductForm()

    var numberOfSections: Int {
        return formFields.numberOfsections
    }

    @objc func cancel() {
        // self.dismiss(animated: true, completion: nil)
    }

    @objc func save() {
        // self.dismiss(animated: true, completion: nil)
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
