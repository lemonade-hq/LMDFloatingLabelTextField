//
//  ViewController.swift
//  LMDTextField
//
//  Created by talthent-l on 01/08/2018.
//  Copyright (c) 2018 talthent-l. All rights reserved.
//

import UIKit
import LMDFloatingLabelTextField

class ViewController: UIViewController {
    
    weak var textField: LMDFloatingLabelTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tf = LMDFloatingLabelTextField(frame: CGRect(x: 20, y: 400, width: 200, height: 48))
        tf.placeholderText = "placeholder"
        self.textField = tf
        tf.text = "Prefilled field"
        self.view.addSubview(tf)
    }
    @IBAction func errorSwitchValueChanged(_ errorSwitch: UISwitch) {
        self.textField.error = errorSwitch.isOn
    }
    
    @IBAction func enableButtonTapped(_ sender: Any) {
        self.textField.disabled = false
    }
    
    @IBAction func disableButtonTapped(_ sender: Any) {
        self.textField.disabled = true
    }
    
    @IBAction func endEditingButtonTapped(_ sender: Any) {
        self.textField.endEditing(true)
    }
}
