//
//  UIUtility.swift
//  CaptureApp-iOS
//
//  Created by Tiago Mendes on 30/12/2019.
//

import Foundation
import UIKit

class UIUtility {

    // Load image in this demo project is different from loading image in a project that implements this pod.
    // This code deals with both situations.
    public func loadImageFromFile(fileName: String, ofType: String) -> UIImage? {
        
        let bundle = Bundle(for: type(of: self))
        if let image = UIImage(named: "CaptureApp-iOS.bundle/\(fileName).\(ofType)", in: bundle, compatibleWith: nil) {
            
            return image
        }
        
        guard let path = bundle.path(forResource: fileName, ofType: ofType) else {
            return nil
        }
        let fileURL = URL(fileURLWithPath: path)
        do {
            let imageData = try Data(contentsOf: fileURL)
            return UIImage(data: imageData)
        } catch {
            print("Error loading image : \(error)")
        }
        return nil
    }
    
}
