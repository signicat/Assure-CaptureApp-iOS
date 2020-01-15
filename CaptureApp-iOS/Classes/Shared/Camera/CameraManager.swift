//
//  CameraManager.swift
//  ios_assure
//
//  Created by Tiago Mendes on 06/12/2018.
//  Copyright © 2018 Signicat. All rights reserved.
//

import UIKit
import AVFoundation

class CameraManager: NSObject {
    
    weak var delegate: CameraManagerDelegate?
    
    private var captureSession: AVCaptureSession?
    public var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    private var capturePhotoOutput: AVCapturePhotoOutput?
    private var qrCodeFrameView: UIView?
    private var previewView: UIView!
    internal var cameraPosition: AVCaptureDevice.Position = .back

    private var cropPhoto: Bool
    
    /// cropPhoto flag the same size of the previewView
    init(delegate: CameraManagerDelegate, previewView: UIView, cropPhoto: Bool = false) {
        
        self.delegate = delegate
        self.previewView = previewView
        self.cropPhoto = cropPhoto
    }
    
    
    /// Instance to be called to prepare Camera Mangager
    public func initialized(cameraIsActivatedQRCode: Bool = false) throws {
        
        guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: cameraPosition) else {
            //fatalError("No video device found")
            return
        }
        
        do {
            
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession = AVCaptureSession()
            captureSession?.addInput(input)
            capturePhotoOutput = AVCapturePhotoOutput()
            capturePhotoOutput?.isHighResolutionCaptureEnabled = true
            captureSession?.addOutput(capturePhotoOutput!)
            
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadataOutput)
            
            if (cameraIsActivatedQRCode) {
                captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                captureMetadataOutput.metadataObjectTypes = [.qr]
            }
            
            if let captureSession = captureSession {
                
                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                videoPreviewLayer?.bounds = previewView.layer.bounds
                videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
                previewView.layer.addSublayer(videoPreviewLayer!)
                captureSession.startRunning()
            } else {
                print("Fail to capture session")
            }            
            
        } catch {
            
            print("\(error)")
            throw error
        }
    }
    
    
    /// Camera Front or Back
    func getVideoPreviewLayer() -> AVCaptureVideoPreviewLayer? {
        return videoPreviewLayer
    }
    
    
    func setPosition(position: AVCaptureDevice.Position) {
        self.cameraPosition = position
    }
    
    
    /// Method for initiating a photo capture request
    func takePhoto(){
        
        guard let capturePhotoOutput = self.capturePhotoOutput else { return }
        let photoSettings = AVCapturePhotoSettings.init(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        photoSettings.isAutoStillImageStabilizationEnabled = true
        photoSettings.isHighResolutionPhotoEnabled = false
        photoSettings.flashMode = .auto
        capturePhotoOutput.capturePhoto(with: photoSettings, delegate: self)
    }
    
    
    func didLayout(){
        self.videoPreviewLayer?.frame = (self.previewView.bounds)
    }
    
    
    func continueRunning(){
        captureSession?.startRunning()
    }
    
    
    /// Crop the photo in a way the resulting image show exactly the content seen
    private func cropToPreviewLayer(originalImage: UIImage) -> UIImage? {
        guard let cgImage = originalImage.cgImage else { return nil }
        
        guard let videoPreviewLayer = self.videoPreviewLayer else {
            return nil
        }
        
        let outputRect = videoPreviewLayer.metadataOutputRectConverted(fromLayerRect: videoPreviewLayer.bounds)

        let width = CGFloat(cgImage.width)
        let height = CGFloat(cgImage.height)
        let cropRect = CGRect(x: outputRect.origin.x * width, y: outputRect.origin.y * height, width: outputRect.size.width * width, height: outputRect.size.height * height)

        if let croppedCGImage = cgImage.cropping(to: cropRect) {
            return UIImage(cgImage: croppedCGImage, scale: 1.0, orientation: originalImage.imageOrientation)
        }

        return nil
    }
    
}


extension CameraManager : AVCapturePhotoCaptureDelegate {
    
    
    /// A callback fired when photos are ready to be delivered to you (RAW or processed).
    ///
    /// - parameter output: The calling instance of AVCapturePhotoOutput.
    /// - parameter photo: An instance of AVCapturePhoto.
    /// - parameter error: An error indicating what went wrong. If the photo was processed successfully, nil is returned.
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        guard error == nil else {
            print("Fail to capture photo: \(String(describing: error))")
            self.delegate?.cameraPhotoOut(capturedImage: nil, error: error, output: output)
            return
        }
        
        guard let imageData = photo.fileDataRepresentation() else {
            print("Fail to convert pixel buffer")
            return
        }
        
        guard let capturedImage = UIImage.init(data: imageData , scale: 1.0) else {
            print("Fail to convert image data to UIImage")
            return
        }
        
        if(self.cropPhoto){
            if let cropImage = self.cropToPreviewLayer(originalImage: capturedImage) {
                
                let imageRightOrientation = cropImage.fixedOrientation()
                self.delegate?.cameraPhotoOut(capturedImage: imageRightOrientation, error: nil, output: output)
            }
        } else {
            self.delegate?.cameraPhotoOut(capturedImage: capturedImage, error: nil, output: output)
        }
    }
    
}


extension CameraManager : AVCaptureMetadataOutputObjectsDelegate {


    /// Called whenever an AVCaptureMetadataOutput instance emits new objects through a connection.
    ///
    /// - parameter output: The AVCaptureMetadataOutput instance that emitted the objects.
    /// - parameter metadataObjects: An array of AVMetadataObject subclasses.
    /// - parameter connection: The AVCaptureConnection through which the objects were emitted.
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            
            guard let delegate = self.delegate else{
                return
            }
            let status = delegate.cameraQROut(stringQR: stringValue)
            if(status){
                captureSession?.stopRunning()
            }
        }
    }
    
}
