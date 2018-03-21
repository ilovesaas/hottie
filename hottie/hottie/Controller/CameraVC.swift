//
//  CameraVC.swift
//  hottie
//
//  Created by Louis Régis on 20.03.18.
//  Copyright © 2018 Louro. All rights reserved.
//

import UIKit
import AVFoundation

class CameraVC: UIImagePickerController {

    @IBOutlet var CameraView: UIView!
    @IBOutlet var CaptureImageView: UIImageView!
    @IBOutlet var FlashBtn: UIButton!
    @IBOutlet var IdentificationLbl: UILabel!
    @IBOutlet var ConfidenceLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
