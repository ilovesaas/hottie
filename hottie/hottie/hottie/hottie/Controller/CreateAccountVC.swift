//
//  CreateAccountVC.swift
//  hottie
//
//  Created by Louis Régis on 21.03.18.
//  Copyright © 2018 Louro. All rights reserved.
//

import UIKit
import Parse
import SceneKit

class CreateAccountVC: UIViewController {
    
// Outlets
    
    //Text Fields
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var universityTextField: UITextField!
    @IBOutlet weak var universityEmailTextField: UITextField!
    
    // Views
    @IBOutlet weak var sceneKitView: SCNView!
    
    
    //Buttons
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var loginBtnCAVC: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bindToKeyboard()
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateAccountVC.handleTap))
        view.addGestureRecognizer(tap)
    }

    // Button Actions- Register and Login in
    @IBAction func loginBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: VIEW_LOGIN, sender: nil)
    }
    
    @IBAction func registerupBtnPressed(_sender: Any) {
        performSegue(withIdentifier: TO_MY_MAP, sender: nil)
        //dismiss keyboard
        self.view.endEditing(true)
        
        // if text fields are empty
        if (fullNameTextField.text?.isEmpty)! || (passwordTextField.text?.isEmpty)! || (universityTextField.text?.isEmpty)! || (universityEmailTextField.text?.isEmpty)! {
            
        //alert message
        let alert = UIAlertController(title: "OOPS!", message: "Please fill all fields", preferredStyle: UIAlertControllerStyle.alert)
        let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        
        // user info to send to server
        
        let user = PFUser()
        
        user.username = fullNameTextField.text
        user.password = passwordTextField.text
        user["univeristy"] = universityTextField.text
        user["universityemail"] = universityEmailTextField.text
        
        //in edit profile its going to be assigned
        user["residencecity"] = ""
        user["nationality"] = ""
        user["fullname"] = ""
        
        user.signUpInBackground { (success:Bool, error:Error?) in
            if success {
                print("Registered")
                
                //remember logged user
                UserDefaults().set(user.username, forKey: "username")
                UserDefaults().synchronize()
                
                // call login fucntion
                let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.login()
        
            } else {
                print("Error")
            }
        }
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }

}

