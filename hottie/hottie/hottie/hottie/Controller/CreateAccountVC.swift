//
//  CreateAccountVC.swift
//  hottie
//
//  Created by Louis Régis on 21.03.18.
//  Copyright © 2018 Louro. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    // Outlets
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func loginBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
    }
    
}
