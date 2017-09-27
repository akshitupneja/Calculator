//
//  ViewController.swift
//  Calculator
//
//  Created by Akshit Upneja on 2017-09-22.
//  Copyright © 2017 Centennial College. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    @IBOutlet weak var display: UILabel!
    var userIsInMiddleOfTyping  = false
    var decimalEnabled = false
    
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        //let currentTextInDisplay = display!.text!
        
       /*
        switch digit {
        
        case "C":
                    userIsInMiddleOfTyping = false
                    display.text = "0"
        case "0" : if userIsInMiddleOfTyping {
            display.text = currentTextInDisplay + digit
        }else {
            display.text = digit
            }
        case ".": break
        default: if userIsInMiddleOfTyping {
            display.text = currentTextInDisplay + digit
            userIsInMiddleOfTyping = true
            }
        else {
            display.text = digit
            userIsInMiddleOfTyping = true
            }
            
            
        }
        */
        
    
        
        
        if userIsInMiddleOfTyping {
            let currentTextInDisplay = display!.text!
            display.text = currentTextInDisplay + digit
        } else {
            if (digit != "0"){
                display.text = digit
                userIsInMiddleOfTyping = true
            }else
            {
                display.text = digit
                userIsInMiddleOfTyping = false
            }
            
        }
 
    }
    
    
    var displayValue : Double {
        get {
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    }
    
    var brain : CalculatorBrain = CalculatorBrain()

    @IBAction func performAction(_ sender: UIButton) {
        
            switch sender.currentTitle! {
            case "C":
                display.text = "0"
                userIsInMiddleOfTyping = false
                
            default:if userIsInMiddleOfTyping {
                brain.setOperand(displayValue)
                userIsInMiddleOfTyping = false
            }
            if let mathematicalSymbol = sender.currentTitle{
                brain.performOperation(mathematicalSymbol)
               
                
            }
            
            if let result = brain.result {
                displayValue = result
                }

            /*brain.setOperand(displayValue)
            userIsInMiddleOfTyping = false*/
        }
        
            }
}

