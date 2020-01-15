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
    
    var captureController: Capture?
    @IBOutlet weak var documentImageView: UIImageView!
    @IBOutlet weak var selfieImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func beginCapture(_ sender: Any) {
        
        print("Begin Capture")
        self.captureController = Capture(delegate: self, documentType: .passport, withSelfie: true)
        let vc = captureController?.run()
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.present(vc!, animated: true, completion: {})
        }
    }
    
    
    // MARK: CaptureDelegate
    
    
    func photoOut(capturedImage: UIImage?, currentStep: StepEnum) {
        
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

