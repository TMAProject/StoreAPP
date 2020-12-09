//
//  FieldTableViewCell.swift
//  StoreAPP
//
//  Created by José João Silva Nunes Alves on 25/11/20.
//

import UIKit

class FieldTableViewCell: UITableViewCell {

    static let reuseIdentifier = "FieldTableViewCell"

    weak var delegate: ProductFieldDelegate?
    var identifier: ProductFields?

    let textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemBackground
        textField.adjustsFontSizeToFitWidth = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = .label
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label

       }()

    let stepper: UIStepper = {
        let stepper = UIStepper()
        stepper.autorepeat = true
        stepper.minimumValue = 0
        stepper.maximumValue = 999
        stepper.translatesAutoresizingMaskIntoConstraints = false
        return stepper
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.backgroundColor = .systemBackground
        self.textField.addTarget(self, action: #selector(didChanged), for: .editingChanged)
        self.stepper.addTarget(self, action: #selector(stepperDidChanged), for: .valueChanged)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        self.contentView.isUserInteractionEnabled = false
        self.addSubview(label)
        self.addSubview(textField)
    }

    private func configureLayout() {
        self.textField.clearButtonMode = .always

        NSLayoutConstraint.activate([
              label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
              label.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.38),
              label.centerYAnchor.constraint(equalTo: self.centerYAnchor),

              textField.topAnchor.constraint(equalTo: self.topAnchor),
              textField.leftAnchor.constraint(equalTo: self.label.rightAnchor, constant: 16),
              textField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
              textField.heightAnchor.constraint(equalToConstant: 44)
          ])
    }

    private func configureLayoutWithStepper() {

        self.addSubview(stepper)
        self.textField.delegate = self

        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            label.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.38),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),

            textField.topAnchor.constraint(equalTo: self.topAnchor),
            textField.leftAnchor.constraint(equalTo: self.label.rightAnchor, constant: 16),
            textField.heightAnchor.constraint(equalToConstant: 44),
            textField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.16),

            stepper.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stepper.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8)
          ])
    }

    func configure(with label: String) {
        self.setup()

        self.identifier = ProductFields(rawValue: label)

        if let identifier = self.identifier {
            self.textField.keyboardType = identifier.keyboardType

            if identifier.keyboardType == .numberPad {
                self.configureLayoutWithStepper()
                self.textField.placeholder = "0"
            } else {
                self.configureLayout()
                self.textField.placeholder = label
            }
        }
        self.label.text = label
    }

    func configureField(with text: String) {
        self.textField.text = text

        if let identifier = self.identifier {
            if identifier.keyboardType == .numberPad {
                self.stepper.value = Double(text)!
            }
        }
    }
}

extension FieldTableViewCell {
    @objc func didChanged(textField: UITextField) {
        if let text = textField.text, let identifier = self.identifier {
            if identifier.keyboardType == .numberPad {
                self.stepper.value = Double(text) ?? 0
            }
            self.delegate?.didUpdateTextField(text: text, field: identifier)
        }
    }

    @objc func stepperDidChanged(stepper: UIStepper) {
        if let identifier = self.identifier {
            let value = "\(Int(stepper.value))"
            self.textField.text = value
            self.delegate?.didUpdateTextField(text: value, field: identifier)
        }
    }
}

extension FieldTableViewCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // get the current text, or use an empty string if that failed
        let currentText = textField.text ?? ""

        // attempt to read the range they are trying to change, or exit if we can't
        guard let stringRange = Range(range, in: currentText) else { return false }

        // add their new text to the existing text
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

        // make sure the result is under 16 characters
        return updatedText.count <= 3
    }
}
