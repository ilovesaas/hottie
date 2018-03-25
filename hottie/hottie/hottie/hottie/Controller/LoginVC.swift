//
//  LoginVC.swift
//  hottie
//
//  Created by Louis Régis on 21.03.18.
//  Copyright © 2018 Louro. All rights reserved.
//

import UIKit
import Parse

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
        
        //hide keyboard
        self.view.endEditing(true)
        
        //if text fields are empty
        if usernameTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            //show alert message
            let alert = UIAlertController(title: "OOPS!", message: "Please fill all fields", preferredStyle: UIAlertControllerStyle.alert)
            let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        // login functions
        PFUser.logInWithUsername(inBackground: usernameTextField.text!, password: passwordTextField.text!) { (user: PFUser?, error: Error?) -> Void in
            if error == nil {
                
                print("logged in")
                
                // remeber user or save in App memory if user logged in or not
                UserDefaults().set(user!.username, forKey: "username")
                UserDefaults().synchronize()
                
                //call login function from appDelegate
                let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.login()
            }
        }
        
        
    }
    
    @IBAction func cancelBtn_Tap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    

}
