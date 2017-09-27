//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Akshit Upneja on 2017-09-23.
//  Copyright © 2017 Centennial College. All rights reserved.
//

import Foundation



struct CalculatorBrain {
    
    private var accumulator: Double?
    
    private enum Operation {
        case constant (Double)
        case unaryOperation ((Double) -> (Double))
        case binaryOperation ((Double,Double) -> Double)
        case equals
        case clear
    }
    
    
    private var operations: Dictionary<String,Operation> = [
        
        "√": Operation.unaryOperation(sqrt),
        "+/-": Operation.unaryOperation({ -$0 }),
        "+": Operation.binaryOperation({ $0 + $1 }),
        "-": Operation.binaryOperation({ $0 - $1 }),
        "÷": Operation.binaryOperation({ $0 / $1 }),
        "x": Operation.binaryOperation({ $0 * $1 }),
        "=": Operation.equals,
        "V": Operation.clear
        
    ]
    
 
    private var pbo : PendingBinaryOperation?
    
    
    private struct PendingBinaryOperation {
        let function : (Double,Double) -> Double
        let firstOperand : Double
        
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand,secondOperand)
        }
    }
    
    
    
    
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
