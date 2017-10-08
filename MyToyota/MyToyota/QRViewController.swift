//
//  QRViewController.swift
//  MyToyota
//
//  Created by Kyrhee Powell on 10/8/17.
//  Copyright © 2017 Biased Life. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

class QRViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate{
    
    @IBOutlet weak var messageLabel: UILabel!
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        
        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            
            // Initialize the captureSession object.
            let captureSession = AVCaptureSession()
            
            // Set the input device on the capture session.
            captureSession.addInput(input)
            
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)
            
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer!)
            
            captureSession.startRunning()
            
            view.bringSubview(toFront: messageLabel)
            
            // Reading QR code
            qrCodeFrameView = UIView()
            
            if let qrCodeFrameView = qrCodeFrameView {
                qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
                qrCodeFrameView.layer.borderWidth = 2
                view.addSubview(qrCodeFrameView)
                view.bringSubview(toFront: qrCodeFrameView)
            }
            
            func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
                
                // Check if the metadataObjects array is not nil and it contains at least one object.
                if metadataObjects == nil || metadataObjects.count == 0 {
                    qrCodeFrameView?.frame = CGRect.zero
                    messageLabel.text = "No QR code is detected"
                    return
                }
                
                // Get the metadata object.
                let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
                
                if metadataObj.type == AVMetadataObject.ObjectType.qr {
                    // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
                    let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
                    qrCodeFrameView?.frame = barCodeObject!.bounds
                    
                    if metadataObj.stringValue != nil {
                        messageLabel.text = metadataObj.stringValue
                    }
                }
            }
            
        } catch {
            // If any error occurs, simply print it out and don't continue any more.
            print(error)
            return
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

