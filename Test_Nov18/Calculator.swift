//
//  ViewController.swift
//  Test_Nov18
//
//  Created by Koushik Reddy Kambham on 11/18/25.
//

import UIKit

class Calculator: UIViewController {
    
    let buttons = [
        ["C", "Back", "", "/"],
        ["7", "8", "9", "*"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "+"],
        ["", "0", ".", "="]
    ]
    
    var currentInput : String = ""
    var currentOperation: String?
    
    var inputTextfield : UITextField = {
        let inputTextfield = UITextField()
        inputTextfield.placeholder = "Enter expressions"
        inputTextfield.translatesAutoresizingMaskIntoConstraints = false
        return inputTextfield
    }()
    
    var resultField: UILabel = {
        let resultField = UILabel()
        resultField.translatesAutoresizingMaskIntoConstraints = false
        return resultField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        createButtons()
    }
    
    func setupUI() {
        view.addSubview(inputTextfield)
        view.addSubview(resultField)
        
        NSLayoutConstraint.activate([
            inputTextfield.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            inputTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            inputTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            resultField.topAnchor.constraint(equalTo: inputTextfield.bottomAnchor, constant: 10),
            resultField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            resultField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
    
    func createButtons() {
        let container = UIStackView()
        container.axis = .vertical
        container.distribution = .fillEqually
        container.spacing = 10
        container.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(container)
        
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            container.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            container.heightAnchor.constraint(equalToConstant: 400)
        ])
        
        for row in buttons {
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.distribution = .fillEqually
            rowStack.spacing = 10
            
            for title in row {
                let btn = UIButton(type: .system)
                btn.setTitle(title, for: .normal)
                btn.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
                
                rowStack.addArrangedSubview(btn)
            }
            container.addArrangedSubview(rowStack)

        }
    }
    
    @objc func buttonTapped(_ btn : UIButton) {
        guard let title = btn.currentTitle else {
            return
        }
        inputOperation(title)
    }
    
    func inputOperation(_ operators: String) {
        switch operators {
        case "C" :
            currentInput = ""
            currentOperation = nil
            inputTextfield.text = "0"
            resultField.text = "0"
            
        case "Back" :
            if !currentInput.isEmpty {
                currentInput.removeLast()
                inputTextfield.text = currentInput.isEmpty ? "0" : currentInput
            }
        case "=" :
            calculateResult()
            
        case "/", "*", "-", "+":
            guard let last = currentInput.last, !"/-*+".contains(last) else {
                return
            }
            currentOperation = operators
            currentInput += operators
            inputTextfield.text = currentInput
            
        default:
            currentInput += operators
            inputTextfield.text = currentInput
        }
    }
    
    func calculateResult() {
        guard let op = currentOperation else { return }
        
        let parts = currentInput.split(separator: Character(op))
        guard parts.count == 2,
              let left = Double(parts[0]),
              let right = Double(parts[1]) else {
            return
        }
        
        var result: Double = 0
        
        switch op {
            case "+": result = left + right
            case "-": result = left - right
            case "*": result = left * right
            case "/": result = left / right
            default: break
        }
        
        resultField.text = "\(Int(result))"
        currentInput = "\(result)"
        currentOperation = nil
    }



}

