//
//  Operation.swift
//  CalculatorApp
//
//  Created by 陳博軒 on 2020/9/21.
//  Copyright © 2020 Bozin. All rights reserved.
//

import Foundation

struct Operation {
    var resultNumber: Double = 0
    var bindingNumber: Double = 0
    var numberOperate: String = ""
    
//    為了能夠在值類型的實力方法中修改屬性值，加入mutating修飾詞
    mutating func result(operate: String, newNumber: Double) -> Double {
//        顯示輸入的第一個值
        if numberOperate == "" {
            resultNumber = newNumber
            bindingNumber = newNumber
            numberOperate = operate
        } else {
//            輸入第二個值後做計算並將結果存回
            switch numberOperate {
            case "+":
                resultNumber = bindingNumber + newNumber
            case "-":
                resultNumber = bindingNumber - newNumber
            case "x":
                resultNumber = bindingNumber * newNumber
            case "÷":
                resultNumber = bindingNumber / newNumber
            default:
                break
            }
            
            bindingNumber = resultNumber
            numberOperate = operate
        }
        return resultNumber
    }
    
    mutating func reset() {
        bindingNumber = 0
        numberOperate = ""
    }

}

