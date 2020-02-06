//
//  UIUtility.swift
//  CaptureApp-iOS
//
//  Created by Tiago Mendes on 30/12/2019.
//

import Foundation
import UIKit

class UIUtility {


    public func loadImageFromFile(fileName: String, ofType: String) -> UIImage? {
        
        let bundle = Bundle(for: type(of: self))
        return UIImage(named: "CaptureApp-iOS.bundle/\(fileName).\(ofType)", in: bundle, compatibleWith: nil)
    }
    
}
