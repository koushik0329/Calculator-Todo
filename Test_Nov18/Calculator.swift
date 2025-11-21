//
//  ViewController.swift
//  Test_Nov18
//
//  Created by Koushik Reddy Kambham on 11/18/25.
//

import UIKit

class Calculator: UIViewController {
    
    let buttons = [
        ["7", "8", "9", "*"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "+"],
        ["0", ".", "Back", "="]
    ]
    
    var currentInput : String = ""
    var currentOperation: String?
    
    var resultField: UILabel = {
        let resultField = UILabel()
        resultField.text = "0"
        resultField.font = UIFont.systemFont(ofSize: 64, weight: .light)
        resultField.textAlignment = .right
        resultField.textColor = .black
        resultField.translatesAutoresizingMaskIntoConstraints = false
        return resultField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        createButtons()
    }
    
    func setupUI() {
        view.addSubview(resultField)
        
        NSLayoutConstraint.activate([
            resultField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            resultField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            resultField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -430)
        ])
    }
    
    func createButtons() {
        // Create first row separately (AC and /)
        let firstRowStack = UIStackView()
        firstRowStack.axis = .horizontal
        firstRowStack.distribution = .fill
        firstRowStack.spacing = 10
        firstRowStack.translatesAutoresizingMaskIntoConstraints = false
        
        // AC button (takes more space)
        let acButton = UIButton(type: .system)
        acButton.setTitle("AC", for: .normal)
        acButton.titleLabel?.font = UIFont.systemFont(ofSize: 28, weight: .regular)
        acButton.layer.cornerRadius = 10
        acButton.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        acButton.setTitleColor(.black, for: .normal)
        acButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
        // Division button
        let divButton = UIButton(type: .system)
        divButton.setTitle("/", for: .normal)
        divButton.titleLabel?.font = UIFont.systemFont(ofSize: 28, weight: .regular)
        divButton.layer.cornerRadius = 10
        divButton.backgroundColor = UIColor(red: 1.0, green: 0.58, blue: 0.0, alpha: 1.0)
        divButton.setTitleColor(.white, for: .normal)
        divButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
        firstRowStack.addArrangedSubview(acButton)
        firstRowStack.addArrangedSubview(divButton)
        
        // Set width constraint for division button to match other buttons
        NSLayoutConstraint.activate([
            divButton.widthAnchor.constraint(equalTo: firstRowStack.widthAnchor, multiplier: 0.23)
        ])
        
        view.addSubview(firstRowStack)
        
        // Create container for remaining rows
        let container = UIStackView()
        container.axis = .vertical
        container.distribution = .fillEqually
        container.spacing = 10
        container.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(container)
        
        NSLayoutConstraint.activate([
            firstRowStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            firstRowStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            firstRowStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -340),
            firstRowStack.heightAnchor.constraint(equalToConstant: 70),
            
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            container.topAnchor.constraint(equalTo: firstRowStack.bottomAnchor, constant: 10),
            container.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        for row in buttons {
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.distribution = .fillEqually
            rowStack.spacing = 10
            
            for title in row {
                let btn = UIButton(type: .system)
                btn.setTitle(title, for: .normal)
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 28, weight: .regular)
                btn.layer.cornerRadius = 10
                
                // Style based on button type
                if title == "Back" {
                    // Gray buttons
                    btn.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
                    btn.setTitleColor(.black, for: .normal)
                } else if "/*-+=".contains(title) {
                    // Orange operator buttons
                    btn.backgroundColor = UIColor(red: 1.0, green: 0.58, blue: 0.0, alpha: 1.0)
                    btn.setTitleColor(.white, for: .normal)
                } else {
                    // Light gray number buttons
                    btn.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
                    btn.setTitleColor(.black, for: .normal)
                }
                
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
        case "AC" :
            currentInput = ""
            currentOperation = nil
            resultField.text = "0"
            
        case "Back" :
            if !currentInput.isEmpty {
                currentInput.removeLast()
                resultField.text = currentInput.isEmpty ? "0" : currentInput
            }
        case "=" :
            calculateResult()
            
        case "/", "*", "-", "+":
            guard let last = currentInput.last, !"/-*+".contains(last) else {
                return
            }
            currentOperation = operators
            currentInput += operators
            resultField.text = currentInput
            
        default:
            currentInput += operators
            resultField.text = currentInput
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
