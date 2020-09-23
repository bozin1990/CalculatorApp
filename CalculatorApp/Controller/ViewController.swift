//
//  ViewController.swift
//  CalculatorApp
//
//  Created by 陳博軒 on 2020/9/21.
//  Copyright © 2020 Bozin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var actionLabel: UILabel!
    @IBOutlet weak var displayLabel: UILabel!
    
    var userInput = false           //使用者是否輸入
    var numberOfInput = false       //是否按下數字鍵
    var decimalInput = false        //小數點是否按過了
    var numberIsZero = false        //數字0是否按過了
    var okText = ""                 //最後顯示的字串
    var operationForRecord = ""     //動作紀錄顯示運算符號
    var operation = Operation()
    
    //    顯示結果String，運算要轉成Double，因此設定一個computed property的變數
    var displayNumber: Double {
        get {
            if displayLabel != nil {
                
                return Double(displayLabel.text!)!
            } else {
                return 0
            }
        }
        
        set(newNumber) {
            if floor(newNumber) == newNumber {
                //                若得出值大於Int最大值結果用Double再轉成字串
                if newNumber > Double(Int.max) {
                    okText = String(newNumber)
                } else {
                    okText = String(Int(newNumber))
                }
            } else {
                okText = String(newNumber)
            }
            
            //            if okText.count >= 10 {
            //                okText = String(okText.prefix(9))
            //            }
            displayLabel.text = okText
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //    覆寫preferredStatusBarStyle屬性，控制狀態列的樣式
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func actionLabelRecoards(from input: String) {
        actionLabel.text = operationForRecord + displayLabel.text!
    }
    
    @IBAction func inputNumbers(_ sender: UIButton) {
        guard let inputNumber = sender.currentTitle else { return }
        
        if userInput {
            //判斷使用者輸入的是否為小數點且小數點狀態為false
            guard inputNumber == ".", decimalInput == false else {
                //判斷使用者是否再度按小數點，及numberIsZero是否為false(為了不讓畫面初始值出現00006這種狀況)，若為ture 直接return
                guard inputNumber != ".", numberIsZero == false else {
                    
                    return
                }
                okText = displayLabel.text! + inputNumber
                //                輸入字數大於等於10的話，那就取 okText，前面10個顯示
                if okText.count >= 10 {
                    okText = String(okText.prefix(10))
                }
                
                displayLabel.text = okText
                actionLabelRecoards(from: displayLabel.text!)
                return
            }
//            為了避免使用者第一次輸入若為0，無法按其他數字鍵，所以numberIsZero存回false
            numberIsZero = false
            decimalInput = true
            displayLabel.text = displayLabel.text! + inputNumber
        } else {
//            如果第一次輸入的是小數點，小數點輸入狀態設為true
            if inputNumber == "." {
                decimalInput = true
                displayLabel.text = "0" + inputNumber
                userInput = true
//                如果第一次輸入的是數字0,數字0輸入狀態設為true
            } else if inputNumber == "0" {
                numberIsZero = true
                displayLabel.text = inputNumber
                userInput = true
            } else {
                displayLabel.text = inputNumber
                userInput = true
            }
            
        }
        actionLabelRecoards(from: displayLabel.text!)
        numberOfInput = true
    }
    
    
    @IBAction func operate(_ sender: UIButton) {
        
        guard let operate = sender.currentTitle else { return }
        
        switch operate {
        case "+", "-", "x", "÷":
            actionLabelRecoards(from: displayLabel.text!)
            if numberOfInput {
                displayNumber = operation.result(operate: operate, newNumber: displayNumber)
                operationForRecord = operate
//                計算完成將所有狀態回到初始值
                userInput = false
                numberOfInput = false
                decimalInput = false
                numberIsZero = false
            } else {
                operationForRecord = operate
                operation.numberOperate = operate
            }
        case "=":
            if numberOfInput {
                displayNumber = operation.result(operate: operate, newNumber: displayNumber)
                
                userInput = false
                numberOfInput = false
                decimalInput = false
                numberIsZero = false
            } else {
                operationForRecord = operate
                operation.numberOperate = operate
            }
        case "%":
            displayNumber = displayNumber / 100
            actionLabelRecoards(from: displayLabel.text!)
            userInput = false
            numberOfInput = true
        case "+/-":
            actionLabelRecoards(from: displayLabel.text!)
            displayNumber = -displayNumber
        case "AC":
            displayNumber = 0
            operation.reset()
            displayLabel.text = "0"
            actionLabel.text = "0"
            operationForRecord = ""
            userInput = false
            numberOfInput = false
            decimalInput = false
            numberIsZero = false
        default:
            break
        }
    }
}

