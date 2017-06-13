//
//  CameraViewController.swift
//  Shayla
//
//  Created by Nakul Desai on 5/24/17.
//  Copyright © 2017 HRW Music Group LLC. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet weak var cameraView: UIView!
    
    var captureSession : AVCaptureSession?
    var stillImageOutput : AVCapturePhotoOutput?
    var previewLayer : AVCaptureVideoPreviewLayer?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        previewLayer?.frame = cameraView.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        captureSession = AVCaptureSession()
        captureSession?.sessionPreset = AVCaptureSessionPreset640x480
        
        var backCamera = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        var error : NSError?
        var input = AVCaptureDeviceInput()
        do {
            input = try AVCaptureDeviceInput(device: backCamera)
        } catch {
            
        }
        
        if error == nil && (captureSession?.canAddInput(input))!{
            
            captureSession?.addInput(input)
            
            /*stillImageOutput = AVCapturePhotoOutput()
            stillImageOutput?. = [AVVideoCodecKey : AVVideoCodecJPEG]*/
            
            previewLayer = AVCaptureVideoPreviewLayer(session : captureSession)
            previewLayer?.videoGravity = AVLayerVideoGravityResizeAspect
            previewLayer?.connection.videoOrientation = AVCaptureVideoOrientation.portrait
            cameraView.layer.addSublayer(previewLayer!)
            captureSession?.startRunning()
            
            
        }
        
    }
}
