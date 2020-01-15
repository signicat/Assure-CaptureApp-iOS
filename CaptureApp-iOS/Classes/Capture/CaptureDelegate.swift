//
//  PhotakerDelegate.swift
//  ios_assure
//
//  Created by Tiago Mendes on 05/12/2019.
//  Copyright © 2019 Signicat. All rights reserved.
//

import Foundation


public protocol CaptureDelegate: class {
    
    
    /// This method will be called after the photo has been captured and validated by the user.
    /// - Parameters:
    ///   - capturedImage: Image that was capture.
    ///   - currentStep: The current step that you are in.
    func photoOut(capturedImage:UIImage?, currentStep: StepEnum)

    
    /// If an error occurs this method will be triggered.
    /// - Parameter error: an error of the type CaptureErrorEnum
    func responseError(error: CaptureErrorEnum)
    
}
