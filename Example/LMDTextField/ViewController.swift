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

    @IBOutlet weak var emailTextField: LMDFloatingLabelTextField!
    @IBOutlet weak var usernameTextField: LMDFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: LMDFloatingLabelTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailTextField.keyboardType = .emailAddress
        [self.usernameTextField, self.emailTextField, self.passwordTextField]
            .forEach { $0?.returnKeyType = .next }
        
        let tf = LMDFloatingLabelTextField(frame: CGRect(x: 20, y: 400, width: 200, height: 48))
        tf.placeholderText = "placeholder"
        self.view.addSubview(tf)
    }
    
    @IBAction func error(_ sender: Any) {
        if let text = usernameTextField?.text, text.count < 6 {
            self.usernameTextField.error = true
        }
        
        if emailTextField.text?.contains("@") == false {
            self.emailTextField.error = true
        }
    }
}
