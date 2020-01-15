//
//  GenericView.swift
//  CaptureApp-iOS
//
//  Created by Tiago Mendes on 18/12/2019.
//

import Foundation
import UIKit


public class GenericView: UIView {
    
    private var spinerFlag: Bool = false
    internal var scrollView: UIScrollView = UIScrollView(frame: .zero)

    
    internal lazy var spinner: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .whiteLarge)
        return activity
    }()
    
    
    private lazy var spinnerBackground: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.addSubview(self.spinner)
        return view
    }()
    
    
    public required init() {
        
        super.init(frame: CGRect.zero)
        initializeUI()
        createConstraints()
        setupAccessibility()
    }
    
    
    public required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        initializeUI()
        createConstraints()
        setupAccessibility()
    }
    
    
    // MARK: Implementation methods
    
    internal func initializeUI() {}
    
    internal func createConstraints() {}
    
    internal func setupAccessibility() {}
    
    
    
    // MARK: Spinner

    
    private func setupSpinner(){
        
        spinnerBackground.isHidden = true
        self.addSubview(spinnerBackground)
        spinnerBackground.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.height.equalTo(spinner.frame.width*2)
        }
        spinner.snp.makeConstraints { make in
            make.centerY.equalTo(spinnerBackground.snp.centerY)
            make.centerX.equalTo(spinnerBackground.snp.centerX)
        }
        self.spinerFlag = true
    }
    
    
    internal func spinnerIsHidden(state: Bool){
        
        if (!self.spinerFlag) {
            setupSpinner()
        }
        spinnerBackground.isHidden = state
    }

    
    // MARK: Tools
    
    
    // Screen width.
    public var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }

    // Screen height.
    public var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    
    private var scaleFactorWidth: Double = {
        let baseWidth : Double = 414
        return Double(UIScreen.main.bounds.width) / baseWidth
    }()
    
    private var scaleFactorHeight: Double = {
        let baseHeight : Double = 896
        return Double(UIScreen.main.bounds.height) / baseHeight
    }()
    
    
    /// Calculate Width keeping the same aspect ratio
    /// If ratio is bigger then 1 we return the same width
    ///
    /// - Parameter oldWidth: width to be changed
    /// - Returns: new width
    public func ratioSafeValue(oldWidth: Double) -> CGFloat {
        let newValue = scaleFactorWidth*oldWidth
        return round((newValue > oldWidth) ? CGFloat(oldWidth) : CGFloat(newValue))
    }
    
    public func ratioSafeValue(oldHeight: Double) -> CGFloat {
        let newValue = scaleFactorWidth*oldHeight
        return round((newValue > oldHeight) ? CGFloat(oldHeight) : CGFloat(newValue))
    }
    
    
    public func ratioSafe(oldWidth: Double) -> CGFloat {
        let scale = scaleFactorWidth
        return (scale > 1) ? 1.0 : CGFloat(scale)
    }
    
    
}
