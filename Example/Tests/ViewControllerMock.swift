//
//  ViewControllerMock.swift
//  CaptureApp-iOS_Example
//
//  Created by Tiago Mendes on 31/12/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import CaptureApp_iOS

class ViewControllerMock: UIViewController, CaptureDelegate {
    
    var lastImage: UIImage?
    var lastImageStep: StepEnum?
    var lastError: CaptureErrorEnum?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func tearDown() {
        
        lastError = nil
        lastImage = nil
        lastImageStep = nil
    }

    // MARK: CaptureDelegate
    
    
    func photoOut(capturedImage: UIImage?, currentStep: StepEnum) {
        
        self.lastImage = capturedImage
        self.lastImageStep = currentStep
    }
    
    
    func responseError(error: CaptureErrorEnum) {
     
        self.lastError = error
    }
    
    
    
    
}

