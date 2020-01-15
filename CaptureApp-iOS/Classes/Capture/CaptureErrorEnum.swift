//
//  PhotakerErrorEnum.swift
//  ios_assure
//
//  Created by Tiago Mendes on 12/12/2019.
//  Copyright © 2019 Signicat. All rights reserved.
//

import Foundation

public enum CaptureErrorEnum : Error, Equatable {

    case cancelByUser

    case network

    case exception(withError: Error?)
    
    
    public static func == (lhs: CaptureErrorEnum, rhs: CaptureErrorEnum) -> Bool {
        switch (lhs, rhs) {
        case (.cancelByUser, .cancelByUser): return true
        case (.network, .network): return true
        case (.exception(let withError1), .exception(let withError2)):
            if withError1?.domain == withError2?.domain && withError1?.code == withError2?.code {
                return true
            }
            return false
        default: return false
        }
    }
    
}
