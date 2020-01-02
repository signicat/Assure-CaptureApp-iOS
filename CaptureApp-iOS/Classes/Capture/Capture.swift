//
//  PhotakerController.swift
//  ios_assure
//
//  Created by Tiago Mendes on 05/12/2019.
//  Copyright © 2019 Signicat. All rights reserved.
//

import Foundation


public class Capture: NSObject {
    
    weak var delegate: CaptureDelegate?
    let stepsEnum: [StepEnum]
    var stepPos: Int = 0 // Position
    let documentType: DocumentTypeEnum
    var navigationController: UINavigationController?
    var currentPhotakerViewController: CaptureViewController?
    var currentPhotakerValidationViewController: CaptureValidationViewController?
    
    
    /// Initialises CaptureApp with Delegate, Document Type and the flag Selfie.
    /// - Parameters:
    ///   - delegate: CaptureDelegate to retrive the results of capture
    ///   - documentType: Selected document
    ///   - withSelfie: Flag to add selfie step
    public init(delegate: CaptureDelegate, documentType: DocumentTypeEnum, withSelfie: Bool) {
        
        self.delegate = delegate
        self.stepsEnum = documentType.getSteps(withSelfie: withSelfie)
        self.documentType = documentType
        super.init()
    }
    
    
    /// Initialises CaptureApp with Delegate, Document Type and Step.
    /// - Parameters:
    ///   - delegate: CaptureDelegate to retrive the results of capture
    ///   - documentType: Selected document
    ///   - stepsEnum: List of steps to be run
    public init(delegate: CaptureDelegate, documentType: DocumentTypeEnum, stepsEnum: [StepEnum]) {
        
        self.delegate = delegate
        self.stepsEnum = stepsEnum
        self.documentType = documentType
        super.init()
    }
    
    
    // MARK: Public
    
    
    /// The first step to run this library that will provide the view controller
    ///
    /// - Returns: ViewController to be present
    public func run() -> UIViewController {
                
        let vc = CaptureViewController(delegate: self, stepEnum: getCurrentStep(), documentType: documentType)
        self.setCurrentVC(vc: vc)
        let navController = UINavigationController(rootViewController: vc)
        self.navigationController = navController
        return navController
    }
    

    /// Function to prompt library to proceed to next step
    ///
    /// - Returns: Enum with the next Step
    public func nextStep() -> StepEnum {
        
        if (self.stepsEnum.count == (self.stepPos + 1)) {
            print("Attention: you already passed the limit of steps nextStep() will be canceled")
            return .end
        }
        self.stepPos = self.stepPos + 1
        self.currentPhotakerValidationViewController?.stopSpinner()
        let currentStep = getCurrentStep()
        let vc = CaptureViewController(delegate: self, stepEnum: currentStep, documentType: documentType)
        self.setCurrentVC(vc: vc)
        self.getNavController()?.pushViewController(vc, animated: true)
        return currentStep
    }
    
    
    public func responseCaptureError(error: CaptureErrorEnum) {
        
        self.delegate?.responseError(error: error)
    }
    
    
    /// Check if you are in the last step of the process
    ///
    /// - Returns: True of False depending on if you are already in the last step
    public func isLastStep() -> Bool {
        
        if (self.stepsEnum.count == (self.stepPos + 1)) {
            return true
        }
        return false
    }
    
    
    // MARK: Internal
    
    
    internal func photoOut(capturedImage:UIImage) {
        
        if(self.isLastStep()) {
            self.currentPhotakerValidationViewController?.dismiss(animated: true, completion: nil)
        }
        self.delegate?.photoOut(capturedImage: capturedImage, currentStep: self.getCurrentStep())
    }
    
    
    internal func getNavController() -> UINavigationController? {
        return self.navigationController
    }
    
    
    internal func getCurrentStep() -> StepEnum {
        self.stepsEnum[self.stepPos]
    }
    
    
    internal func setCurrentVC(vc: CaptureViewController) {
        self.currentPhotakerViewController = vc
    }
    
    
    internal func setCurrentVC(vc: CaptureValidationViewController) {
        self.currentPhotakerValidationViewController = vc
    }
    
}
