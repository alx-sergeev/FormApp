//
//  ViewController.swift
//  FormApp
//
//  Created by Сергеев Александр on 11.02.2022.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var clearButton: UIButton!
    
    // MARK: - Properties
    private let cellName = "myCell"
    private let cellChildName = "myChildCell"
    private let maxAddChildBlock = 5
    private var groupsName: [String] {
        ["Персональные данные", "Дети (макс. \(maxAddChildBlock))"]
    }
    private var childs: [Child] = []
    private var person: Person!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.dataSource = self
        myTableView.delegate = self
        
        myTableView.keyboardDismissMode = .onDrag
        
        clearButton.layer.cornerRadius = 22
        clearButton.layer.borderWidth = 1
        clearButton.layer.borderColor = UIColor.red.cgColor
        clearButton.tintColor = .red
    }
    
    @IBAction func clearButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Очистка формы", message: "Хотите очистить форму?", preferredStyle: .actionSheet)
        
        let resetAction = UIAlertAction(title: "Сбросить данные", style: .destructive) { [weak self] _ in
            guard let self = self else { return }
            
            
            self.childs = []
            self.person = nil
            
            self.myTableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alert.addAction(resetAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == 0) ? 1 : childs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let numSection = indexPath.section
        
        if numSection == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as! MyCell
            
            cell.configureCell(cell: cell, person: person)
            
            cell.nameTextField.addTarget(self, action: #selector(savePersonName), for: .editingChanged)
            cell.ageTextField.addTarget(self, action: #selector(savePersonAge), for: .editingChanged)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellChildName, for: indexPath) as! MyChildCell
            let row = indexPath.row
            let child = childs[row]
            
            cell.configureCell(tableView: tableView, cell: cell, child: child)
            
            cell.deleteButton.addTarget(self, action: #selector(deleteChildButtonPressed), for: .touchUpInside)
            cell.deleteButton.tag = row
            
            cell.nameTextField.delegate = self
            cell.nameTextField.tag = row
            
            cell.ageTextField.delegate = self
            cell.ageTextField.tag = row
            
            return cell
        }
    }
}

// MARK: UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let placeholder: String! = textField.placeholder
        let row = textField.tag
        
        if childs.indices.contains(row) {
            if placeholder == "Имя" {
                childs[row].name = textField.text
            } else if placeholder == "Возраст" {
                childs[row].age = textField.text
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.sectionHeaderHeight))

        // Section title
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = groupsName[section]
        titleLabel.font = UIFont(name: "Helvetica Neue", size: 20)
        
        headerView.addSubview(titleLabel)
        setupTitleForHeader(headerView: headerView, title: titleLabel)
        
        if section == 1 && childs.count < maxAddChildBlock {
            // Button
            let addButton = UIButton(type: .system)
            addButton.translatesAutoresizingMaskIntoConstraints = false
            addButton.setTitle("+ Добавить ребенка", for: .normal)
            addButton.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 18)
            addButton.layer.cornerRadius = 22
            addButton.layer.borderWidth = 1
            addButton.layer.borderColor = addButton.tintColor.cgColor
            
            addButton.addTarget(self, action: #selector(addChildAction), for: .touchUpInside)
            
            headerView.addSubview(addButton)
            
            setupAddButtonForHeader(headerView: headerView, button: addButton)
        }

        return headerView
    }
}

// MARK: - Constraints for Header
extension ViewController {
    func setupTitleForHeader(headerView: UIView, title: UILabel) {
        title.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16).isActive = true
        title.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16).isActive = true
        title.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
    }
    
    func setupAddButtonForHeader(headerView: UIView, button: UIButton) {
        button.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16).isActive = true
        button.widthAnchor.constraint(equalToConstant: 200).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
    }
}

// MARK: - User actions
extension ViewController {
    @objc func addChildAction(_ sender: UIButton) {
        let child = Child(name: nil, age: nil)
        
        childs.append(child)
        
        myTableView.reloadData()
    }
    
    @objc func deleteChildButtonPressed(_ button: UIButton) {
        let buttonTag = button.tag
        
        childs.remove(at: buttonTag)
        
        myTableView.reloadData()
    }
    
    @objc func savePersonName(_ sender: UITextField) {
        if person != nil {
            person.name = sender.text
        } else {
            person = Person(name: sender.text, age: nil)
        }
    }
    
    @objc func savePersonAge(_ sender: UITextField) {
        if person != nil {
            person.age = sender.text
        } else {
            person = Person(name: nil, age: sender.text)
        }
    }
}
