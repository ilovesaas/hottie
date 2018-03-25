//
//  CameraVC.swift
//  hottie
//
//  Created by Louis Régis on 20.03.18.
//  Copyright © 2018 Louro. All rights reserved.
//

import UIKit
import AVFoundation
import CoreML
import Vision

class CameraVC: UIImagePickerController {
    
    var captureSessions: AVCaptureSession!
    var cameraOutput: AVCapturePhotoOutput!
    var previewLayer: AVCaptureVideoPreviewLayer!

    var photoData: Data?



    @IBOutlet var CameraView: UIView!



    @IBOutlet var FlashBtn: RoundedShadowButton!
    @IBOutlet var IdentificationLbl: UILabel!
    @IBOutlet var ConfidenceLbl: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()

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

    func resultsMethod(request: VNRequest, error: Error?) {
        guard let results = request.results as? [VNClassificationObservation] else { return }

        for classification in results {
            if classification.confidence < 0.5 {
                self.IdentificationLbl.text = "I'm not sure what this is. Please try again."
                self.ConfidenceLbl.text = ""
                break
            }  else {
                self.IdentificationLbl.text = classification.identifier
                self.ConfidenceLbl.text = "CONFIDENCE: \(Int(classification.confidence * 100))%"
                break
            }
        }
    }
}

extension CameraVC: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            debugPrint(error)
        } else {
            photoData = photo.fileDataRepresentation()

            do {
                let model = try VNCoreMLModel(for: SqueezeNet().model)
                let request = VNCoreMLRequest(model: model, completionHandler: resultsMethod)
                let handler = VNImageRequestHandler(data: photoData!)
                try handler.perform([request])

            }catch {
                debugPrint(error)
            }

            let image = UIImage(data: photoData!)


        }
    }
}
