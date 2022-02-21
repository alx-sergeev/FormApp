//
//  MyCell.swift
//  FormApp
//
//  Created by Сергеев Александр on 11.02.2022.
//

import UIKit

class MyCell: UITableViewCell {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    
    func configureCell(cell: MyCell, person: Person? = nil) {
        let nameTF: UITextField! = cell.nameTextField
        let ageTF: UITextField! = cell.ageTextField
        
        nameTF.text = ""
        ageTF.text = ""
        
        if let person = person {
            nameTF.text = person.name
            ageTF.text = person.age
        }
        
        nameTF.autocapitalizationType = UITextAutocapitalizationType.sentences
        ageTF.keyboardType = .numberPad
        
        nameTF.translatesAutoresizingMaskIntoConstraints = false
        ageTF.translatesAutoresizingMaskIntoConstraints = false
        
        nameTF.heightAnchor.constraint(equalToConstant: 45).isActive = true
        nameTF.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 16).isActive = true
        nameTF.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -16).isActive = true
        nameTF.topAnchor.constraint(equalTo: cell.topAnchor, constant: 0).isActive = true

        ageTF.heightAnchor.constraint(equalToConstant: 45).isActive = true
        ageTF.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 16).isActive = true
        ageTF.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -16).isActive = true
        ageTF.topAnchor.constraint(equalTo: nameTF.bottomAnchor, constant: 10).isActive = true
        
        cell.selectionStyle = .none
    }
}
