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
    
    func performOperation(_ symbol : String ) {
        
    }
    
    mutating func setOperand(_ operand: Double){
        accumulator = operand
    }
    
    var result: Double? {
        get {
            return accumulator
        }
    }

}
