//
//  ViewController.swift
//  CaptureApp-iOS
//
//  Created by Tiago Mendes on 12/18/2019.
//  Copyright (c) 2019 Tiago Mendes. All rights reserved.
//

import UIKit
import CaptureApp_iOS

class ViewController: UIViewController, CaptureDelegate {
    
    var captureController: CaptureApp?
    @IBOutlet weak var documentImageView: UIImageView!
    @IBOutlet weak var selfieImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func beginCapture(_ sender: Any) {
        
        print("Begin Capture")
        self.captureController = CaptureApp(delegate: self, documentType: .passport, withSelfie: true)
        
        /*
        // Help how to customize the CaptureApp
        var customization = CaptureCustomization()
        customization.primaryColor = [UIColor(red: 255/255, green: 1/255, blue: 2/255, alpha: 1), UIColor(red: 1, green: 40/255, blue: 201/255, alpha: 1)]
        customization.cancelColor = [UIColor(red: 1/255, green: 66/255, blue: 132/255, alpha: 1), UIColor(red: 1, green: 40/255, blue: 201/255, alpha: 1), UIColor(red: 233, green: 40/255, blue: 77/255, alpha: 1)]
        customization.fontName = "Papyrus"
        self.captureController?.customizations(customization)*/
        
        let vc = captureController?.run()
        self.present(vc!, animated: true, completion: {})
    }
    
    
    // MARK: CaptureDelegate
    
    
    func photoOut(capturedImage: UIImage?, currentStep: CaptureStepEnum) {
        
        print("PHOTO OUT")
        
        switch currentStep {
        case .front:
            self.documentImageView.image = capturedImage
            self.documentImageView.backgroundColor = UIColor.white
        case .selfie:
            self.selfieImageView.image = capturedImage
            self.selfieImageView.backgroundColor = UIColor.white
        default:
            break
        }
        
        if(self.captureController?.nextStep() == .end) {
            print("Finish")
        }
    }
    
    
    func responseError(error: CaptureErrorEnum) {
     
        print(error)
    }
    
}

