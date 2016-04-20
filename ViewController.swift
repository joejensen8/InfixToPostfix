//
//  ViewController.swift
//  InfixToPostfix
//
//  Created by Joseph Jensen on 2/4/16.
//  Copyright © 2016 Joseph Jensen. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var infixTextField: UITextField!
    @IBOutlet weak var postfixLabel: UILabel!

    @IBAction func convertButton(sender: UIButton) {
    
        guard let infix: String = infixTextField.text! else { return }
        let postfix = infixToPostfix(infix)
        postfixLabel.text = postfix
    }
    
    func infixToPostfix (infix: String) -> String {
        
        var postfix: String = ""
        var stack = [Character] ()
        
        for char in infix.characters {
            switch (char) {
            case "(" :
                stack.insert(char, atIndex: 0)
                
            case ")" :
                // pop stack and append until matching ")" occurs
                while (stack.first != "(") {
                    postfix.append(stack.removeFirst()) // pop top of stack and append to string
                }
                stack.removeFirst() // removes "("
                
            case "+", "-", "*", "/":
                while (!stack.isEmpty && stack.first != "(" && !lowerPrecedence(stack.first!, op2: char)) { // was char, stack.first!
                    postfix.append(stack.removeFirst())
                }
                stack.insert(char, atIndex: 0) // push new operator on
                
            default :
                postfix.insert(char, atIndex: postfix.endIndex) // default case is for numbers
            }
        }
        
        while (!stack.isEmpty) {
            postfix.append(stack.removeFirst())
        }
        
        return postfix
        
    }
    
    // returns true if op1 is of lower precedence than op2
    func lowerPrecedence (op1: Character, op2: Character) -> Bool {
        switch (op1) {
        case "+" :
            return !(op2 == "-" || op2 == "+")
        case "-" :
            return !(op2 == "-" || op2 == "+")
        case "*" :
            return op2 == "("
        case "/" :
            return op2 == "("
        case "(" :
            return true
        default : // shouldn't happen
            return false
        }
    }
    
}

