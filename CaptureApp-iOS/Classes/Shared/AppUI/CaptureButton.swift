//
//  CaptureButton.swift
//  ios_assure
//
//  Created by Tiago Mendes on 13/12/2018.
//  Copyright © 2018 Signicat. All rights reserved.
//

import UIKit

class CaptureButton: UIButton {
    
    private let pathLayer = CAShapeLayer()
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        initialize()
    }
    
    
    private func initialize() {
        
        layer.cornerRadius =  frame.size.height / 2
        backgroundColor = Theme.Color.rectagleGrey
        layer.borderWidth = 1.0
        layer.borderColor = Theme.Color.black.cgColor
        
        layer.shadowColor = Theme.Color.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.masksToBounds = false
        layer.shadowRadius = 1.0
        layer.shadowOpacity = 0.8
        
        pathLayer.path = innerCirclePath().cgPath
        pathLayer.strokeColor = Theme.Color.black.cgColor
        pathLayer.lineWidth = 4.0
        pathLayer.fillColor = Theme.Color.white.cgColor
        pathLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(pathLayer)
        layer.contentsScale = UIScreen.main.scale
    }
    
    func getDefaultHeight() -> Float {
        return 75.0
    }
    
    
    private func innerCirclePath() -> UIBezierPath
    {
        let min = 8.0
        let rect = CGRect(x:min, y:min, width:Double(self.frame.width)-min*2, height:Double(self.frame.height)-min*2)
        return UIBezierPath(roundedRect: rect, cornerRadius: 25)
    }
    
    
    override open var isHighlighted: Bool {
        didSet {
            pathLayer.fillColor = (isHighlighted) ? Theme.Color.lightGrey.cgColor : Theme.Color.white.cgColor
        }
    }
}
