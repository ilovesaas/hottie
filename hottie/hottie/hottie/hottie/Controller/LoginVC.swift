//
//  LoginVC.swift
//  hottie
//
//  Created by Louis Régis on 21.03.18.
//  Copyright © 2018 Louro. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var forgotPasswordBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func loginBtn_Tap(_ sender: Any) {
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
    }
    
    @IBAction func cancelBtn_Tap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    

}
