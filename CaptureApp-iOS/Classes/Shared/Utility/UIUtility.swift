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
        guard let path = bundle.path(forResource: fileName, ofType: ofType) else
        {
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
