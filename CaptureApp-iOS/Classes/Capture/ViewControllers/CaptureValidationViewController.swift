//
//  PhotakerValidationViewController.swift
//  ios_assure
//
//  Created by Tiago Mendes on 05/12/2019.
//  Copyright © 2019 Signicat. All rights reserved.
//

import UIKit

class CaptureValidationViewController: GenericViewController<CaptureValidationView> {
    
    
    weak var delegate: CaptureApp?
    let stepEnum: CaptureStepEnum
    let documentType: CaptureDocumentTypeEnum
    var docPhoto: UIImage
    var customization: CaptureCustomization?
    
    init(delegate: CaptureApp, stepEnum: CaptureStepEnum, documentType: CaptureDocumentTypeEnum, docPhoto: UIImage, customization: CaptureCustomization? = nil) {
        
        self.delegate = delegate
        self.stepEnum = stepEnum
        self.documentType = documentType
        self.docPhoto = docPhoto
        self.customization = customization
        
        super.init()
        self.delegate?.setCurrentVC(vc: self)
        
        if let customization = self.customization {
            if let primaryGradientColors = customization.primaryColor {
                self.contentView.buttonIsReadable.gradientColors = primaryGradientColors
            }
            if let cancelGradientColors = customization.cancelColor {
                self.contentView.buttonTakeNewPicture.gradientColors = cancelGradientColors
            }
            if let fontName = customization.fontName {
                self.contentView.setFont(fontName: fontName)
            }
        }
    }
    
    
    public required init?(coder: NSCoder){
        fatalError()
    }
    
    
    override func loadView() {
        super.loadView()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        contentView.btnClose.addTarget(self, action: #selector(self.dismissPresenter), for: .touchUpInside)
        contentView.buttonIsReadable.addTarget(self, action: #selector(self.isReadable), for: .touchUpInside)
        contentView.buttonTakeNewPicture.addTarget(self, action: #selector(self.goBack), for: .touchUpInside)
    }
    
    
    override func viewDidLayoutSubviews() {
        
        contentView.adaptToStep(docType: documentType, stepEnum: stepEnum)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        contentView.setDocImage(docImage: docPhoto)
    }
    
    
    override func dismissPresenter() {
        
        self.delegate?.responseCaptureError(error: .cancelByUser)
        super.dismissPresenter()
    }
    
    
    @objc private func isReadable() {
        
        self.startSpinner()
        
        let image = self.docPhoto
        let size = (self.stepEnum == .selfie) ? WideUtility.calculateResizeforImage(image, scaledToHeight: 640) : WideUtility.calculateResizeforImage(image, scaledToWidth: 1024)
        let newImage = image.resizeImage(targetSize: size)
        
        self.delegate?.photoOut(capturedImage: newImage)
    }
    
}
