//
//  WideUtility.swift
//  CaptureApp-iOS
//
//  Created by Tiago Mendes on 31/12/2019.
//

import Foundation
import UIKit


struct WideUtility {

    
    static func calculateResizeforImage(_ sourceImage:UIImage, scaledToWidth: CGFloat) -> CGSize {
        
        let oldWidth = sourceImage.size.width
        let oldHeight = sourceImage.size.height
        if(oldWidth < scaledToWidth) { // Don't do notting if image smaller then the scaled to
            return CGSize(width: oldWidth, height: oldHeight)
        }
        let scaleFactor = scaledToWidth / oldWidth
        let newHeight = oldHeight * scaleFactor
        let newWidth = oldWidth * scaleFactor
        
        return CGSize(width: newWidth, height: newHeight)
    }
    
    
    static func calculateResizeforImage(_ sourceImage:UIImage, scaledToHeight: CGFloat) -> CGSize {
        
        let oldHeight = sourceImage.size.height
        let oldWidth = sourceImage.size.width
        if(oldHeight < scaledToHeight) { // Don't do notting if image smaller then the scaled to
            return CGSize(width: oldWidth, height: oldHeight)
        }
        let scaleFactor = scaledToHeight / oldHeight

        let newWidth = oldWidth * scaleFactor
        let newHeight = oldHeight * scaleFactor
        
        return CGSize(width: newWidth, height: newHeight)
    }
    
    
}
