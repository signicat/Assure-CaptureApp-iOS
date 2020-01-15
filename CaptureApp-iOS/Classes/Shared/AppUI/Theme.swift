//
//  Theme.swift
//  ios_assure
//
//  Created by Tiago Mendes on 07/12/2018.
//  Copyright © 2018 Signicat. All rights reserved.
//

import UIKit


struct Theme {
    
    struct Font {
        
        static func Default(fontSize: CGFloat, weight: UIFont.Weight) -> UIFont {
            
            return UIFont.systemFont(ofSize: fontSize, weight: weight)
        }
        
        static func body() -> UIFont {
            return main(ofSize: 16.0, weight: .regular)
        }
        
        static func main(ofSize fontSize: CGFloat, weight: weight) -> UIFont{
            
            switch weight {
            case .semiBold: return self.Default(fontSize: fontSize, weight: .semibold)
            case .bold: return self.Default(fontSize: fontSize, weight: .bold)
            default: return self.Default(fontSize: fontSize, weight: .regular)
            }
        }
        
        enum weight {
            case regular
            case semiBold
            case bold
        }
        
    }
    
    
    struct Color {
        
        /// White
        static let background = UIColor.init(red: 255, green: 255, blue: 255)
        /// rgb 249 249 249
        static let backgroundAlternative = UIColor.init(red: 249, green: 249, blue: 249)
        static let rectagleGrey = UIColor.init(red: 242, green: 242, blue: 242)
        
        static let white = UIColor.white
        static let black = UIColor.black
        
        static let lightGrey = UIColor.init(red: 82, green: 82, blue: 82)
        
        struct Text {
            /// red: 33, green: 40, blue: 49
            static let main = UIColor.init(red: 33, green: 40, blue: 49)
            /// red: 155, green: 155, blue: 155
            static let grey = UIColor.init(red: 155, green: 155, blue: 155)
            /// red: 41, green: 52, blue: 64
            static let dark = UIColor.init(red: 41, green: 52, blue: 64)
            /// red: 41, green: 138, blue: 248
            static let blue = UIColor.init(red: 41, green: 138, blue: 248)
            /// rgb 41 52 64
            static let darkBlue = UIColor.init(red: 41, green: 52, blue: 64)
        }
        
        
        struct Btn {
            
            static let blueLeft = UIColor.init(red: 97, green: 210, blue: 250)
            static let blueRight = UIColor.init(red: 28, green: 122, blue: 247)
            
            static func gradientCgColor() -> [CGColor] {
                return [blueLeft.cgColor, blueRight.cgColor]
            }
            
            static func gradientColor() -> [UIColor] {
                return [blueLeft, blueRight]
            }
            
        }

    }
    
}
