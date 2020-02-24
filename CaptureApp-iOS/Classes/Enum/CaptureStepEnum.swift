//
//  PaperValidationStep.swift
//  ios_assure
//
//  Created by Tiago Mendes on 21/12/2018.
//  Copyright © 2018 Signicat. All rights reserved.
//

import Foundation


public enum CaptureStepEnum {
    
    case front
    case back
    case selfie
    case end
    
    func getStringify() -> String {
        
        switch self {
        case .front: return "front"
        case .back: return "back"
        case .selfie: return "selfie"
        default: return ""
        }
    }
    
}
