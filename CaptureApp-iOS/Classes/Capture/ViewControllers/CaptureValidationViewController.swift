//
//  PhotakerValidationViewController.swift
//  ios_assure
//
//  Created by Tiago Mendes on 05/12/2019.
//  Copyright © 2019 Signicat. All rights reserved.
//

import UIKit

class CaptureValidationViewController: GenericViewController<CaptureValidationView> {
    
    
    weak var delegate: Capture?
    let stepEnum: StepEnum
    let documentType: DocumentTypeEnum
    var docPhoto: UIImage
    
    
    init(delegate: Capture, stepEnum: StepEnum, documentType: DocumentTypeEnum, docPhoto: UIImage) {
        
        self.delegate = delegate
        self.stepEnum = stepEnum
        self.documentType = documentType
        self.docPhoto = docPhoto
        super.init()
        
        self.delegate?.setCurrentVC(vc: self)
    }
    
    
    public required init?(coder: NSCoder){
        fatalError()
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
