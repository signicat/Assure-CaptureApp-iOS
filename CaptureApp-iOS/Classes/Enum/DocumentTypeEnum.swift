//
//  DocumentType.swift
//  ios_assure
//
//  Created by Tiago Mendes on 05/12/2018.
//  Copyright © 2018 Signicat. All rights reserved.
//

import Foundation

public enum DocumentTypeEnum: String, Codable, CaseIterable {
    
    case passport = "passport"
    case drivingLicence = "driversLicense"
    case identityCard = "identityCard"
    case residencePermit = "residencePermit"
    case unknown
    
    public init(from decoder: Decoder) throws {
        self = try DocumentTypeEnum(rawValue: decoder.singleValueContainer().decode(String.self)) ?? .unknown
    }
    
    
    func getStringify() -> String {
        
        switch self {
        case .passport: return "Passport"
        case .drivingLicence: return "Driver's License"
        case .identityCard: return "National Identity Card"
        case .residencePermit: return "Residence Permit Card"
        default: return "License"
        }
    }
    
    
    func getStringForValidationScreen() -> String {
        
        switch self {
        case .passport: return "passport"
        case .drivingLicence: return "license"
        case .identityCard: return "card"
        case .residencePermit: return "permit"
        default: return "license"
        }
    }
    
    
    func getSteps(withSelfie: Bool) -> [StepEnum] {
        
        var steps: [StepEnum] = []
        switch self {
            case .passport:
                steps.append(.front)
            default:
                steps.append(.front)
                steps.append(.back)
        }
        if(withSelfie){ steps.append(.selfie) }
        return steps
    }
    
}
