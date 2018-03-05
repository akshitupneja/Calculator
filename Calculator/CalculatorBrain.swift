//
//  CalculatorBrain.swift
//  Calculator
//  Student ID: 300976590
//  Version: 1.0
//  Created by Akshit Upneja on 2017-09-23.
//  Copyright © 2017 Centennial College. All rights reserved.
//

import Foundation

// Struct is similar to Class with a diffence that it initializes everything automatically inlike class

struct CalculatorBrain {
    
    private var accumulator: Double? // accumulator will store result
    
    
    private enum Operation {
        case constant (Double)
        case unaryOperation ((Double) -> (Double))
        case binaryOperation ((Double,Double) -> Double)
        case equals
        case clear
    }
    
    //Below method defines kind of opertion done by arithematic operators
    private var operations: Dictionary<String,Operation> = [
        
        "√": Operation.unaryOperation(sqrt),
        "+/-": Operation.unaryOperation({ -$0 }),
        "+": Operation.binaryOperation({ $0 + $1 }),
        "-": Operation.binaryOperation({ $0 - $1 }),
        "÷": Operation.binaryOperation({ $0 / $1 }),
        "x": Operation.binaryOperation({ $0 * $1 }),
        "=": Operation.equals,
        "C": Operation.clear
        
    ]
    
 
    private var pbo : PendingBinaryOperation?
    
    // This method is called when equals is pressed. This will evaluate Operand1 Operation Operand2
    private struct PendingBinaryOperation {
        let function : (Double,Double) -> Double
        let firstOperand : Double
        
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand,secondOperand)
        }
    }
    
    
    
    //mutating keyword is used to modify a variable/function in a Struct
    //Below fuctions handles different operation when operator is pressed
    mutating func performOperation(_ symbol : String ) {
        if let operation = operations[symbol] {
            switch operation {
            case .unaryOperation(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
            
            case .binaryOperation(let function) :
                if accumulator != nil {
                    pbo = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                    
                }
                
        
            case .equals :
                performPendingBinaryOperation()
            
            case .clear :
                clear()
                
            default:
                break
            }// end of switch
        }//end of if
        
    }// end of function
    
    
    
    
    private mutating func performPendingBinaryOperation(){
        if pbo != nil && accumulator != nil {
            accumulator = pbo!.perform(with: accumulator!)
            pbo = nil
        }// End of if
    } //end of function
    
    
    
    
    mutating func setOperand(_ operand: Double){
        accumulator = operand
    }
    
    //variable for storing result. it is only readable by any other file in this application.
    var result: Double? {
        get {
            return accumulator
        }
    }

    mutating private func clear() {
        accumulator = nil
        pbo = nil

    }
}
