//
//  GallianoButton.swift
//  ios_assure
//
//  Created by Tiago Mendes on 23/10/2019.
//  Copyright © 2019 Signicat. All rights reserved.
//

import Foundation


class GallianoButton: UIButton {
    
    var gradientColors : [UIColor]
    let startPoint : CGPoint
    let endPoint : CGPoint
    
    var halfOfButtonHeight: CGFloat = 0.0
    
    required init(gradientColors: [UIColor] = Theme.Color.Btn.gradientColor(),
                  startPoint: CGPoint = CGPoint(x: 0, y: 0.5),
                  endPoint: CGPoint = CGPoint(x: 1, y: 0.5)) {
        self.gradientColors = gradientColors
        self.startPoint = startPoint
        self.endPoint = endPoint
        
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        halfOfButtonHeight = layer.frame.height / 2
        contentEdgeInsets = UIEdgeInsets(top: 16.3, left: halfOfButtonHeight, bottom: 14.8, right: halfOfButtonHeight)
        
        layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        layer.cornerRadius =  5.0

        backgroundColor = UIColor.clear
        
        setupGradient(gradientColors: gradientColors)
        
        /*layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 5.0).cgPath
        layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        layer.shadowOpacity = 0.85
        layer.shadowRadius = 4.0*/
        
        titleLabel?.textAlignment = .center
        setTitleColor(Theme.Color.white, for: .normal)
        titleLabel?.font = Theme.Font.main(ofSize: 18, weight: .semiBold)
    }
    
    
    func setupGradient(gradientColors: [UIColor]) {
        
        // setup gradient
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = gradientColors.map { $0.cgColor }
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.cornerRadius = 5.0
        
        // replace gradient as needed
        if let oldGradient = layer.sublayers?[0] as? CAGradientLayer {
            layer.replaceSublayer(oldGradient, with: gradient)
        } else {
            layer.insertSublayer(gradient, below: nil)
        }
    }
    
    
    override var isHighlighted: Bool {
        didSet {
            
            let xScale : CGFloat = isHighlighted ? 1.025 : 1.0
            let yScale : CGFloat = isHighlighted ? 1.05 : 1.0
            UIView.animate(withDuration: 0.1) {
                let transformation = CGAffineTransform(scaleX: xScale, y: yScale)
                self.transform = transformation
            }
        }
    }
    
    
    static func getDefaultMargin() -> Float {
        return 40.0
    }
    
}
