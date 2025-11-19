//
//  TodoViewController.swift
//  Test_Nov18
//
//  Created by Koushik Reddy Kambham on 11/18/25.
//

import UIKit

struct TodoList {
    var title: String?
    var isCompleted: Bool
}

class TodoViewController : UIViewController , UITableViewDataSource, UITableViewDelegate {
    
    var todos : [TodoList] = []
    
    var tableView : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    var textField : UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter a new Task"
        return textField
    }()
    
    var addButton : UIButton = {
        let addButton = UIButton(type: .system)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.setTitle("+", for: .normal)
        return addButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        
        tableView.dataSource = self
        tableView.delegate = self
        
        addButton.addTarget(self, action: #selector(addTodo), for: .touchUpInside)
        
        view.addSubview(textField)
        view.addSubview(addButton)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -10),
            textField.heightAnchor.constraint(equalToConstant: 40),

            addButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addButton.widthAnchor.constraint(equalToConstant: 40),
            addButton.heightAnchor.constraint(equalToConstant: 40),

            tableView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let todo = todos[indexPath.row]
        cell.textLabel?.text = todo.title
        cell.imageView?.image = todo.isCompleted ? UIImage(systemName: "checkmark.circle.fill") : nil
        
        let removeButton = UIButton(type: .system)
        removeButton.setTitle("Remove", for: .normal)
        removeButton.setTitleColor(.red, for: .normal)
        removeButton.frame = CGRect(x: 0, y: 0, width: 70, height: 30)
        removeButton.tag = indexPath.row
        removeButton.addTarget(self, action: #selector(removeTodoButtonTapped(_:)), for: .touchUpInside)
        
        cell.accessoryView = removeButton
        
        return cell
    }
    
    @objc func addTodo() {
        guard let text = textField.text, !text.isEmpty else {
            return
        }
        todos.append(TodoList(title: text,isCompleted: false))
        textField.text = ""
        tableView.reloadData()
    }
    
    @objc private func removeTodoButtonTapped(_ sender: UIButton) {
        removeTodo(at: sender.tag)
    }
    
    @objc func removeTodo(at index: Int) {
        todos.remove(at: index)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        todos[indexPath.row].isCompleted.toggle()
        tableView.reloadData()
    }
}
