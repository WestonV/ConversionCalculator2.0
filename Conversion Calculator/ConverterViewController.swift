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
    var outputSuffix : String = ""
    
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
        outputSuffix = outputDisplay.text!
    }
    
    @IBAction func converterButtonTapped(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Choose Converter", message: "", preferredStyle: UIAlertController.Style.actionSheet)
        for converter in converters {
            actionSheet.addAction(UIAlertAction(title: converter.label, style: UIAlertAction.Style.default, handler: {
                (alertAction) -> Void in
                self.inputDisplay.text = converter.inputUnit
                self.outputDisplay.text = converter.outputUnit
                self.inputSuffix = converter.inputUnit
                self.outputSuffix = converter.outputUnit
            }))
        }
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
        inputNumber = ""
    }
   
    var positiveNumber = true
    func changeNumSign() {
        if positiveNumber {
            positiveNumber = false
            inputNumber.insert("-", at: inputNumber.startIndex)
            printNumber()
        } else {
            positiveNumber = true
            inputNumber.remove(at: inputNumber.startIndex)
            printNumber()
        }
    }
    
    func printNumber(){
        inputDisplay.text = inputNumber + " \(inputSuffix)"
    }
    
    func convertValues() {
        if inputNumber == "" {
            inputDisplay.text = inputSuffix
            outputDisplay.text = outputSuffix
            return
        }
        var outputNumber = 0.0
        switch inputSuffix {
        case "km":
            outputNumber = Double(inputNumber)! / 1.609
            outputDisplay.text = String(format: "%.1f", outputNumber) + " mi"
        case "mi":
            outputNumber = Double(inputNumber)! * 1.609
            outputDisplay.text = String(format: "%.1f", outputNumber) + " ki"
        case "°C":
            outputNumber = Double(inputNumber)! * 1.8 + 32.0
            outputDisplay.text = String(format: "%.1f", outputNumber) + " °F"
        case "°F":
            outputNumber = (Double(inputNumber)! - 32.0) * (5/9)
            outputDisplay.text = String(format: "%.1f", outputNumber) + " °C"
        default:
            break
        }
    }
    
    var hasDecimal = false
    
    //sender.tag of 10 = clear button, 11 = +- button, and 12 = decimal button
    @IBAction func buttonsTapped(_ sender: UIButton) {
        if sender.tag <= 9 {
            inputNumber += String(sender.tag)
            printNumber()
        }
        if sender.tag == 10 {
            inputNumber = ""
            printNumber()
            hasDecimal = false
        }
        if sender.tag == 12 && !hasDecimal {
            inputNumber += "."
            hasDecimal = true
            printNumber()
        }
        if sender.tag == 12 && hasDecimal {
            return
        }
        if sender.tag == 11 {
            changeNumSign()
        }
        convertValues()
    }
    
    
}
