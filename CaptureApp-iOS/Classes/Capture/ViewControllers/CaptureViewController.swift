//
//  PhotakerViewController.swift
//  ios_assure
//
//  Created by Tiago Mendes on 05/12/2019.
//  Copyright © 2019 Signicat. All rights reserved.
//

import UIKit
import AVFoundation

class CaptureViewController: GenericViewController<CaptureView>, UIAdaptivePresentationControllerDelegate {
    
    weak var delegate: CaptureApp?
    let stepEnum: CaptureStepEnum
    let documentType: CaptureDocumentTypeEnum
    internal var cameraManager: CameraManager?
    var timer = Timer()
    var customization: CaptureCustomization?
    
    
    init(delegate: CaptureApp, stepEnum: CaptureStepEnum, documentType: CaptureDocumentTypeEnum, customization: CaptureCustomization? = nil) {
        
        self.delegate = delegate
        self.stepEnum = stepEnum
        self.documentType = documentType
        self.customization = customization
        super.init()
    }
    
    
    public required init?(coder: NSCoder){
        
        fatalError()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cameraManager = CameraManager(delegate: self, previewView: self.contentView.previewView, cropPhoto: true)
        do {
            if (stepEnum == .selfie) {
                self.cameraManager?.setPosition(position: .front)
            }
            try self.cameraManager?.initialized()
        } catch let error {
            self.delegate?.responseCaptureError(error: .exception(withError: error))
            super.dismissPresenter()
        }
        contentView.btnClose.addTarget(self, action: #selector(self.dismissPresenter), for: .touchUpInside)
        contentView.captureButton.addTarget(self, action: #selector(self.takePhotoTapped), for: .touchUpInside)
        
        if #available(iOS 13.0, *) { // Disable the sheet in iOS 13 to be dismissed by pulling down
            presentationController?.delegate = self
            isModalInPresentation = true
        }
        
        if let customization = self.customization {
            if let fontName = customization.fontName {
                self.contentView.setFont(fontName: fontName)
            }
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
            self.contentView.adaptToStep(docType: self.documentType, stepEnum: self.stepEnum)
            self.cameraManager?.didLayout()
        }
    }
    
    
    // Function that checks if the camera is working, this is useful because it was happening
    // that when he went to background mode in the selfie mode the camera did not continue
    @objc func checkCameraStatus(){
        
        if let isRunning = self.cameraManager?.isRunning() {
            if(!isRunning) {
                self.cameraManager?.continueRunning()
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.checkCameraStatus), userInfo: nil, repeats: true)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.timer.invalidate()
    }
    
    
    override func dismissPresenter() {
        
        self.delegate?.responseCaptureError(error: .cancelByUser)
        super.dismissPresenter()
    }
    
    
    @objc func takePhotoTapped() {
        
        contentView.captureButton.isEnabled = false
        self.cameraManager?.takePhoto()
    }
    
    
    func navigateValidation(image: UIImage) {
        
        DispatchQueue.main.async {
            
            self.contentView.captureButton.isEnabled = true
            let vc = CaptureValidationViewController(delegate: self.delegate!, stepEnum: self.stepEnum, documentType: self.documentType, docPhoto: image, customization: self.customization)
            self.delegate?.getNavController()?.pushViewController(vc, animated: true)
        }
    }
    
    
    deinit {
        self.timer.invalidate()
    }
    
}



extension CaptureViewController: CameraManagerDelegate{
   
    
    func cameraPhotoOut(capturedImage: UIImage?, error: Error?, output: AVCapturePhotoOutput) {
                
            if let image = capturedImage {
                self.navigateValidation(image: image)
            }else{
                DispatchQueue.main.async {
                    self.contentView.captureButton.isEnabled = true
                }
            }
        
    }
    
    
    func cameraQROut(stringQR: String) -> Bool { return false }
    
}

