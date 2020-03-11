//
//  CaptureValidationView.swift
//  ios_assure
//
//  Created by Tiago Mendes on 05/12/2019.
//  Copyright © 2019 Signicat. All rights reserved.
//

import UIKit
import SnapKit


class CaptureValidationView: GenericView {
    
    private(set) var btnClose = UIButton(type: UIButton.ButtonType.system)
    private(set) var photoFrame = UIImageView()
    private(set) var label = UILabel()
    private(set) var buttonIsReadable = GallianoButton()
    private(set) var buttonTakeNewPicture = GallianoButton(gradientColors: [UIColor.init(hex: "#E3E0E0", a: 1), UIColor.init(hex: "#7A7A7A",a: 1)], startPoint: CGPoint(x: 0, y: 0.5), endPoint: CGPoint(x: 1, y: 0.5))

    
    internal override func initializeUI() {
 
        scrollView.backgroundColor = Theme.Color.white
        self.addSubview(scrollView)
        
        scrollView.addSubview(btnClose)
        if let image = UIUtility().loadImageFromFile(fileName: "icon_cross", ofType: "png") {
            image.withRenderingMode(.alwaysTemplate)
            btnClose.setImage(image, for: .normal)
            btnClose.tintColor = Theme.Color.black
            btnClose.contentMode = .scaleAspectFit
            btnClose.imageEdgeInsets = UIEdgeInsets(top: -14, left: -14, bottom: -14, right: -14)
        }
        
        photoFrame.layer.cornerRadius = 10
        photoFrame.clipsToBounds = true
        photoFrame.backgroundColor = UIColor.gray
        scrollView.addSubview(photoFrame)
        
        scrollView.addSubview(label)
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        
        scrollView.addSubview(buttonIsReadable)
        
        scrollView.addSubview(buttonTakeNewPicture)
        buttonTakeNewPicture.setTitle("Take a new photo", for: .normal)
    }
    
    
    internal override func createConstraints() {
        
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).priority(750)
            make.bottom.left.right.equalTo(self).priority(1000)
        }
        
        btnClose.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView.snp.top).offset(20)
            make.right.equalTo(scrollView.snp.right).offset(-20)
            make.width.height.equalTo(40)
        }
        
        photoFrame.snp.makeConstraints { make in
            make.top.equalTo(btnClose.snp.bottom).offset(30)
            make.centerX.equalTo(scrollView.snp.centerX)
            make.left.equalTo(scrollView).offset(12)
            make.right.equalTo(scrollView).offset(-12)
            make.height.equalTo(photoFrame.snp.width).multipliedBy(0.63)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(photoFrame.snp.bottom).offset(30)
            make.centerX.equalTo(scrollView.snp.centerX)
            make.left.equalTo(scrollView).offset(12)
            make.right.equalTo(scrollView).offset(-12)
        }
        
        buttonTakeNewPicture.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-30)
            make.leading.equalTo(scrollView).offset(30)
            make.trailing.equalTo(scrollView).offset(-30)
        }
        
        buttonIsReadable.snp.makeConstraints { make in
            make.bottom.equalTo(buttonTakeNewPicture.snp.top).offset(-15)
            make.leading.equalTo(scrollView).offset(30)
            make.trailing.equalTo(scrollView).offset(-30)
        }
        
    }
    
    
    internal override func setupAccessibility() {
    }
    
    
    func setDocImage(docImage: UIImage) {
        photoFrame.image = docImage
        photoFrame.contentMode = .scaleToFill
        photoFrame.clipsToBounds = true
    }
    
    
    func adaptToStep(docType: CaptureDocumentTypeEnum, stepEnum: CaptureStepEnum) {
        
        switch stepEnum {
        case .selfie:
            photoFrame.snp.removeConstraints()
            photoFrame.snp.updateConstraints { make in
                make.top.equalTo(btnClose.snp.bottom).offset(30)
                make.centerX.equalTo(self.snp.centerX)
                make.height.equalTo(self.snp.height).multipliedBy(0.5)
                make.width.equalTo(photoFrame.snp.height).multipliedBy(0.63)
            }
            label.isHidden = true
            buttonIsReadable.setTitle("My selfie is readable", for: .normal)
            break
        default:
            label.text = "Make sure your "+docType.getStringForValidationScreen()+" details are clear to read, with no blur or glare"
            buttonIsReadable.setTitle("My "+docType.getStringForValidationScreen()+" is readable", for: .normal)
            break
        }
    }
    
    
    func setFont(fontName: String) {
        
        var descriptor = UIFontDescriptor(name: fontName, size: 15.0)
        descriptor = descriptor.addingAttributes([UIFontDescriptor.AttributeName.traits : [UIFontDescriptor.TraitKey.weight : UIFont.Weight.medium]])
        let fontLabel = UIFont(descriptor: descriptor, size: 15.0)
        label.font = fontLabel
    }
    
}
