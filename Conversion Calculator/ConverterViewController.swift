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
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func converterButtonTapped(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Choose Converter", message: "", preferredStyle: UIAlertController.Style.actionSheet)
        for converter in converters {
            actionSheet.addAction(UIAlertAction(title: converter.label, style: UIAlertAction.Style.default, handler: {
                (alertAction) -> Void in
                self.inputDisplay.text = converter.inputUnit
                self.outputDisplay.text = converter.outputUnit
            }))
        }
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
}
