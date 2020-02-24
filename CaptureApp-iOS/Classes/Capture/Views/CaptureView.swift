//
//  CaptureView.swift
//  ios_assure
//
//  Created by Tiago Mendes on 05/12/2019.
//  Copyright © 2019 Signicat. All rights reserved.
//

import UIKit
import SnapKit


class CaptureView: GenericView {
    
    private(set) var btnClose = UIButton(type: UIButton.ButtonType.system)
    private(set) var backgroundView = UIView()
    private(set) var previewView = UIView()
    private(set) var captureButton = CaptureButton(type: UIButton.ButtonType.system)
    private(set) var label = UILabel()
    private(set) var subLabel = UILabel()
    private(set) var logoImage = UIImageView()
        
    internal override func initializeUI() {
        
        self.backgroundColor = Theme.Color.background
        addSubview(btnClose)
        
        if let image = UIUtility().loadImageFromFile(fileName: "icon_cross", ofType: "png") {
            image.withRenderingMode(.alwaysTemplate)
            btnClose.setImage(image, for: .normal)
            btnClose.tintColor = Theme.Color.black
            btnClose.contentMode = .scaleAspectFit
            btnClose.imageEdgeInsets = UIEdgeInsets(top: -14, left: -14, bottom: -14, right: -14)
        }
        
        addSubview(backgroundView)
        backgroundView.addSubview(previewView)
        
        backgroundView.addSubview(captureButton)
        previewView.backgroundColor = UIColor.black
        previewView.layer.cornerRadius = 10
        previewView.clipsToBounds = true
        previewView.bringSubviewToFront(captureButton)
        
        backgroundView.addSubview(label)
        label.textColor = Theme.Color.Text.main
        label.font = Theme.Font.main(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        backgroundView.addSubview(subLabel)
        subLabel.textColor = Theme.Color.Text.main
        subLabel.font = Theme.Font.main(ofSize: 16, weight: .regular)
        subLabel.textAlignment = .center
        subLabel.adjustsFontSizeToFitWidth = true
        subLabel.numberOfLines = 1

        backgroundView.addSubview(logoImage)
        logoImage.image = UIUtility().loadImageFromFile(fileName: "signicat_logo", ofType: "png")
        
    }
    
    
    internal override func createConstraints() {
        
        btnClose.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            make.right.equalTo(self.snp.right).offset(-20)
            make.width.height.equalTo(40)
        }
        
        backgroundView.snp.makeConstraints { make in
            make.top.equalTo(btnClose.snp.bottom)
            make.left.right.equalTo(self)
            make.bottom.equalTo(self.snp.bottom)
        }
        
        previewView.snp.makeConstraints { make in
            make.centerY.equalTo(backgroundView.snp.centerY)
            make.centerX.equalTo(backgroundView.snp.centerX)
            make.left.equalTo(backgroundView).offset(12)
            make.right.equalTo(backgroundView).offset(-12)
            make.height.equalTo(backgroundView.snp.width).multipliedBy(0.63)
        }
        
        captureButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-30)
            make.centerX.equalTo(backgroundView.snp.centerX)
            make.width.height.equalTo(captureButton.getDefaultHeight())
        }
        
        label.snp.makeConstraints { make in
            make.centerX.equalTo(backgroundView.snp.centerX)
            make.top.equalTo(backgroundView).offset(30)
        }
        
        subLabel.snp.makeConstraints { make in
            make.centerX.equalTo(backgroundView.snp.centerX)
            make.top.equalTo(label.snp.bottom).offset(15)
            make.leading.equalTo(self).offset(10)
            make.trailing.equalTo(self).offset(-10)
        }
        
        logoImage.snp.makeConstraints { make in
            make.centerX.equalTo(backgroundView.snp.centerX)
            make.bottom.equalTo(previewView.snp.top).offset(-8)
            make.width.equalTo(38)
            make.height.equalTo(38)
        }
    }
    
    
    override internal func setupAccessibility() {

    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    func setFont(fontName: String) {
        
        var descriptor = UIFontDescriptor(name: fontName, size: 24.0)
        descriptor = descriptor.addingAttributes([UIFontDescriptor.AttributeName.traits : [UIFontDescriptor.TraitKey.weight : UIFont.Weight.bold]])
        let fontLabel = UIFont(descriptor: descriptor, size: 24.0)
        label.font = fontLabel
        
        var descriptor2 = UIFontDescriptor(name: fontName, size: 16.0)
        descriptor2 = descriptor2.addingAttributes([UIFontDescriptor.AttributeName.traits : [UIFontDescriptor.TraitKey.weight : UIFont.Weight.regular]])
        let fontSubLabel = UIFont(descriptor: descriptor, size: 16.0)
        subLabel.font = fontSubLabel
        
    }
    
    
    func adaptToStep(docType: CaptureDocumentTypeEnum, stepEnum: CaptureStepEnum) {
        
        switch stepEnum {
        case .selfie:
            label.text = "Take a Selfie"
            previewView.snp.removeConstraints()
            previewView.snp.updateConstraints { make in
                make.top.equalTo(label.snp.bottom).offset(5)
                make.centerX.equalTo(self.snp.centerX)
                make.height.equalTo(self.snp.height).multipliedBy(0.5)
                make.width.equalTo(previewView.snp.height).multipliedBy(0.63)
                setNeedsUpdateConstraints()
            }
            logoImage.isHidden = true
            
        case .back:
            subLabel.text = "Position the back of your "+docType.getStringForValidationScreen()+" in the frame"
            switch docType {
            case .passport: label.text = ""
            case .drivingLicence: label.text = "Back of driver's license"
            case .identityCard: label.text = "Back of card"
            case .residencePermit: label.text = "Back of permit"
            default: label.text = "Back of license"
            }
        default:
            subLabel.text = "Position the front of your "+docType.getStringForValidationScreen()+" in the frame"
            switch docType {
            case .passport:
                label.text = "Passport photo page"
                subLabel.text = "Position the page with your photo in the frame"
            case .drivingLicence: label.text = "Front of driver's license"
            case .identityCard: label.text = "Front of card"
            case .residencePermit: label.text = "Front of permit"
            default: label.text = "Front of license"
            }
        }

    }
    
}

