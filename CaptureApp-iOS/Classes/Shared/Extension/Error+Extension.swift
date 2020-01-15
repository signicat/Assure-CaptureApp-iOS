//
//  Error+Extension.swift
//  ios_assure
//
//  Created by Tiago Mendes on 04/06/2019.
//  Copyright © 2019 Signicat. All rights reserved.
//

import Foundation

extension Error {
    
    var code: Int { return (self as NSError).code }
    var domain: String { return (self as NSError).domain }
}
