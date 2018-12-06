//
//  ConverterViewController.swift
//  Conversion Calculator
//
//  Created by Weston Verhulst on 10/22/18.
//  Copyright © 2018 Weston Verhulst. All rights reserved.
//

import UIKit


class ConverterViewController: UIViewController {
    
    @IBOutlet weak var inputDisplay: UITextField!
    @IBOutlet weak var outputDisplay: UITextField!
    
    var inputNumber : String = ""
    var inputSuffix : String = ""
    
    var converters = [Converter(label: "fahrenheit to celcius", inputUnit: "°F", outputUnit: "°C"),
                      Converter(label: "celcius to fahrenheit", inputUnit: "°C", outputUnit: "°F"),
                      Converter(label: "miles to kilometer", inputUnit: "mi", outputUnit: "km"),
                      Converter(label: "kilometer to miles", inputUnit: "km", outputUnit: "mi")
                      ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        inputDisplay.text = converters[0].inputUnit
        outputDisplay.text = converters[0].outputUnit
        inputSuffix = inputDisplay.text!
    }
    
    @IBAction func converterButtonTapped(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Choose Converter", message: "", preferredStyle: UIAlertController.Style.actionSheet)
        for converter in converters {
            actionSheet.addAction(UIAlertAction(title: converter.label, style: UIAlertAction.Style.default, handler: {
                (alertAction) -> Void in
                self.inputDisplay.text = converter.inputUnit
                self.outputDisplay.text = converter.outputUnit
                self.inputSuffix = converter.inputUnit
            }))
        }
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
        inputNumber = ""
    }
   
//    var posOrNegNum : Bool = true
//    func changeNumSign() {
//        if posOrNegNum {
//            posOrNegNum = false
//            inputNumber.insert("-", at: inputNumber.startIndex)
//            printNumber()
//        }
//        if !posOrNegNum {
//            posOrNegNum = true
//            inputNumber.remove(at: inputNumber.startIndex)
//            printNumber()
//        }
//    }
    
    func printNumber(){
        inputDisplay.text = inputNumber
        print(inputSuffix)
    }
    
    func convertValues() {
        if inputNumber == "" {
            outputDisplay.text = ""
            return
        }
        var outputNumber = 0.0
        switch inputSuffix {
        case "km":
            outputNumber = Double(inputNumber)! / 1.609
            outputDisplay.text = String(format: "%.1f", outputNumber)
        case "mi":
            outputNumber = Double(inputNumber)! * 1.609
            outputDisplay.text = String(format: "%.1f", outputNumber)
        case "°C":
            outputNumber = Double(inputNumber)! * 1.8 + 32.0
            outputDisplay.text = String(format: "%.1f", outputNumber)
        case "°F":
            outputNumber = (Double(inputNumber)! - 32.0) * (5/9)
            outputDisplay.text = String(format: "%.1f", outputNumber)
        default:
            break
        }
    }
    
    //sender.tag of 10 = clear button, 11 = +- button, and 12 = decimal button
    @IBAction func buttonsTapped(_ sender: UIButton) {
        if sender.tag <= 9 {
            inputNumber += String(sender.tag)
            printNumber()
        }
        if sender.tag == 10 {
            inputNumber = ""
            printNumber()
        }
        if sender.tag == 12 {
            inputNumber += "."
            printNumber()
        }
//        if sender.tag == 11 && posOrNegNum {
//            changeNumSign()
//        }
//        if sender.tag == 11 && !posOrNegNum  {
//            changeNumSign()
//        }
//        print(posOrNegNum)
        convertValues()
    }
    
    
}
