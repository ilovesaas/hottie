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
    
    var captureSessions: AVCaptureSession!
    var cameraOutput: AVCapturePhotoOutput!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    var photoData: Data?
    

    @IBOutlet var CameraView: UIView!
    @IBOutlet var CaptureImageView: RoundedShadowImageView!
    @IBOutlet var FlashBtn: RoundedShadowButton!
    @IBOutlet var IdentificationLbl: UILabel!
    @IBOutlet var ConfidenceLbl: UILabel!
    @IBOutlet var RoundedLblView: RoundedShadow!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        previewLayer.frame = CameraView.bounds
    
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapCameraView))
        tap.numberOfTapsRequired = 1
        
        captureSessions = AVCaptureSession()
        captureSessions.sessionPreset = AVCaptureSession.Preset.hd1920x1080
        
        let backCamera = AVCaptureDevice.default(for: AVMediaType.video)
        
        do {
            let input = try AVCaptureDeviceInput(device: backCamera!)
            if captureSessions.canAddInput(input) == true {
                captureSessions.addInput(input)
                
            }
            cameraOutput = AVCapturePhotoOutput()
            
            if captureSessions.canAddOutput(cameraOutput) == true {
                captureSessions.addOutput(cameraOutput!)
                
                previewLayer = AVCaptureVideoPreviewLayer(session: captureSessions!)
                previewLayer.videoGravity = AVLayerVideoGravity.resizeAspect
                previewLayer.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
                
                CameraView.layer.addSublayer(previewLayer!)
                CameraView.addGestureRecognizer(tap)
                captureSessions.startRunning()
            }
        } catch {
            debugPrint(error)
            
        }
        
    }
    
    @objc func didTapCameraView() {
        let settings = AVCapturePhotoSettings()
        
        settings.previewPhotoFormat = settings.embeddedThumbnailPhotoFormat
        
        cameraOutput.capturePhoto(with: settings, delegate: self)
        
    }
    

    

    
}

extension CameraVC: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            debugPrint(error)
        } else {
            photoData = photo.fileDataRepresentation()
            
            let image = UIImage(data: photoData!)
            self.CaptureImageView.image = image
        }
    }
}
