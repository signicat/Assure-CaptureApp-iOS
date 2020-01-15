//
//  CameraManagerDelegate.swift
//  ios_assure
//
//  Created by Tiago Mendes on 06/12/2018.
//  Copyright © 2018 Signicat. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

protocol CameraManagerDelegate: class {
    
    
    /// This method will be called after photo capture.
    /// - parameter capturedImage:  Image that was capture.
    /// - parameter error:          An error indicating what went wrong. If the photo was processed successfully, nil is returned.
    /// - parameter output:         The calling instance of AVCapturePhotoOutput.
    func cameraPhotoOut(capturedImage:UIImage?, error: Error?, output: AVCapturePhotoOutput)
        
    
    /// This function will be called every time a QR code is found by the camera
    ///
    /// - parameter stringQR:       String contained in the QR Code
    ///
    /// - returns:  A True/False, we check if the QR code string is what we look for,
    ///             if is returned true then Camera Manager can stop searching for new QRs
    func cameraQROut(stringQR: String) -> Bool
    
}
