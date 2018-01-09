//
//  ViewController.swift
//  LMDTextField
//
//  Created by talthent-l on 01/08/2018.
//  Copyright (c) 2018 talthent-l. All rights reserved.
//

import UIKit
import LMDTextField

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: LMDTextField!
    @IBOutlet weak var usernameTextField: LMDTextField!
    @IBOutlet weak var passwordTextField: LMDTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailTextField.keyboardType = .emailAddress
        [self.usernameTextField, self.emailTextField, self.passwordTextField]
            .forEach { $0?.returnKeyType = .next }
        
        let tf = LMDTextField(frame: CGRect(x: 20, y: 400, width: 200, height: 48))
        tf.placeholderText = "placeholder"
        self.view.addSubview(tf)
    }
}

