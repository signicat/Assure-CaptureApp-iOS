//
//  Data+Extension.swift
//  ios_assure
//
//  Created by Tiago Mendes on 06/03/2019.
//  Copyright © 2019 Signicat. All rights reserved.
//

import Foundation

extension Data {
    
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
    
}
