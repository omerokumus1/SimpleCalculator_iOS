//
//  ViewController.swift
//  SimpleCalculator
//
//  Created by Ömer Faruk Okumuş on 29.12.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    private var input: [String?] = []
    private var isFirstClick = true
    private var isOperatorClicked = false
    private var acCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func buttonPressed(_ sender: UIButton) {
        if sender.currentTitle == "AC" {
            label.text = "0"
            isFirstClick = true
            acCount += 1
            if acCount == 2 {
                input.removeAll()
                acCount = 0
            }
        } else if isButtonEqual(sender) {
            input.append(label.text)
            input.append(sender.currentTitle)
            label.text = getResult()
            input.removeAll()
            isFirstClick = true
            acCount = 0
        } else {
            if isFirstClick {
                isFirstClick = false
                label.text = ""
            }
            if isOperatorClicked {
                isOperatorClicked = false
                label.text = ""
            }
            if isButtonNumber(sender) || isButtonDot(sender) {
                label.text = (label.text ?? "") + (sender.currentTitle ?? "")
            } else if isButtonOperator(sender) {
                if label.text != "" || label.text != nil {
                    input.append(label.text)
                }
                
                input.append(sender.currentTitle)
                label.text = sender.currentTitle
                isOperatorClicked = true
            }
            acCount = 0
        }
    }
    
    private func isButtonEqual(_ button: UIButton) -> Bool {
        button.currentTitle == "="
    }
    
    private func isButtonNumber(_ button: UIButton) -> Bool {
        ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"].contains(button.currentTitle)
    }
    
    private func isButtonDot(_ button: UIButton) -> Bool {
        button.currentTitle == "."
    }
    
    private func isButtonOperator(_ button: UIButton) -> Bool {
        ["+", "-", "*", "/"].contains(button.currentTitle)
    }
    
    
    
    private func getResult() -> String {
        if isInputValid() {
            var result = Int(input.first!!)!
            
            var i = 1
            while i < input.count-2 {
                let op = input[i]!
                let number = Int(input[i+1]!)!
                let temp = operate(result, op, number)
                if temp != "NaN" {
                    if let temp2 = Int(temp) {
                        result = temp2
                    } else {
                        return "NaN"
                    }
                } else {
                    return "NaN"
                }
                i += 2
            }
            return String(result)
        }
        return "NaN"
    }
    
    private func isInputValid() -> Bool {
        var i = 0
        while i < input.count-1 {
            if  !(isNumber(input[i]) && isOperator(input[i+1])) {
                return false
            }
            i += 2
        }
        return true
    }
    
    private func isNumber(_ str: String?) -> Bool {
        var isNum = str?.isEmpty != true
        if isNum != false {
            var numbers: [Character] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
            str?.forEach { s in
                isNum = isNum && numbers.contains(s)
            }
        }
        return isNum && (str?.isEmpty != true)
    }
    
    private func isOperator(_ str: String?) -> Bool {
        var isOp = str?.isEmpty != true
        if isOp != false {
            let operators: [Character] = ["+", "-", "*", "/", "="]
            str?.forEach { s in
                isOp = isOp && operators.contains(s)
            }
        }
        
        return isOp
    }
    
    private func operate(_ numberOne: Int, _ op: String, _ numberTwo: Int) -> String {
        switch op {
            case "+": return String(numberOne + numberTwo)
            case "-": return String(numberOne - numberTwo)
            case "*": return String(numberOne * numberTwo)
            case "/":
                if numberTwo == 0 {
                    return "NaN"
                } else {
                    return String(numberOne / numberTwo)
                }
            
            default: return "0"
        }
    }
    
}

