//
//  MyChildCell.swift
//  FormApp
//
//  Created by Сергеев Александр on 13.02.2022.
//

import UIKit

class MyChildCell: UITableViewCell {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var deleteButton: UIButton!
    
    func configureCell(tableView: UITableView, cell: MyChildCell, child: Child) {
        let nameTF: UITextField! = cell.nameTextField
        let ageTF: UITextField! = cell.ageTextField
        let deleteButton: UIButton! = cell.deleteButton
        
        nameTF.autocapitalizationType = UITextAutocapitalizationType.sentences
        ageTF.keyboardType = .numberPad
        
        nameTF.text = child.name
        ageTF.text = child.age
        
        nameTF.translatesAutoresizingMaskIntoConstraints = false
        ageTF.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.translatesAutoresizingMaskIntoConstraints = false

        nameTF.widthAnchor.constraint(equalTo: tableView.widthAnchor, multiplier: 0.5).isActive = true
        nameTF.heightAnchor.constraint(equalToConstant: 45).isActive = true
        nameTF.leadingAnchor.constraint(equalTo: tableView.leadingAnchor, constant: 16).isActive = true
        nameTF.topAnchor.constraint(equalTo: cell.topAnchor, constant: 0).isActive = true

        deleteButton.leftAnchor.constraint(equalTo: nameTF.rightAnchor, constant: 8).isActive = true
        deleteButton.centerYAnchor.constraint(equalTo: nameTF.centerYAnchor).isActive = true

        ageTF.widthAnchor.constraint(equalTo: tableView.widthAnchor, multiplier: 0.5).isActive = true
        ageTF.heightAnchor.constraint(equalToConstant: 45).isActive = true
        ageTF.leadingAnchor.constraint(equalTo: nameTF.leadingAnchor).isActive = true
        ageTF.topAnchor.constraint(equalTo: nameTF.bottomAnchor, constant: 8).isActive = true
        
        cell.selectionStyle = .none
    }
}
