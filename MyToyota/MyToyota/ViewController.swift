//
//  ViewController.swift
//  MyToyota
//
//  Created by Curtis Hite on 10/7/17.
//  Copyright © 2017 Biased Life. All rights reserved.
//

import UIKit
import Alamofire
import FlexibleSteppedProgressBar
import AVFoundation

class ViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var messageField: UITextField!

    @IBAction func sendData(_ sender: Any) {
        let  headers = ["Content-Type": "application/x-www-form-urlencoded"]
        
        let parameters: Parameters = ["To": phoneNumberField.text ?? "","Body": messageField.text ?? ""]
        
        Alamofire.request("http://381a7463.ngrok.io/", method: .post, parameters: parameters, headers: headers).response
            { response in
                print(response)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}



