//
//  Fonts.swift
//  iTunesSearchAPI
//
//  Created by Sandy Ludosky on 23/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import UIKit

struct Fonts {
    struct Roboto {
        static var regular: UIFont = Fonts.font("Roboto-Regular")
        static var black: UIFont = Fonts.font("Roboto-Black")
        static var bold: UIFont = Fonts.font("Roboto-Bold")
        static var light: UIFont = Fonts.font("Roboto-Light")
        static var medium: UIFont = Fonts.font("Roboto-Medium")
        static var thin: UIFont = Fonts.font("Roboto-Thin")
        
        struct Italic {
            static var regular: UIFont = Fonts.font("Roboto-Italic")
            static var black: UIFont = Fonts.font("Roboto-BlackItalic")
            static var bold: UIFont = Fonts.font("Roboto-BoldItalic")
            static var light: UIFont = Fonts.font("Roboto-LightItalic")
            static var medium: UIFont = Fonts.font("Roboto-MediumItalic")
            static var thin: UIFont = Fonts.font("Roboto-ThinItalic")
        }
    }
    struct HelveticaNeue {
        static var regular: UIFont = Fonts.font("HelveticaNeue")
    }
    struct System {
        static var semibold: UIFont = Fonts.font(.semibold)
    }
    
    /**
     Retreive fonts from name.
     
     - Parameters:
     - name: The font name.
     */
    private static func font(_ name: String) -> UIFont {
        return UIFont(name: name, size: 17.0) ?? UIFont.systemFont(ofSize: 60.0)
    }
    
    /**
     Retreive fonts from system.
     
     - Parameters:
     - weight: The font weight.
     */
    private static func font(_ weight: UIFont.Weight) -> UIFont {
        return UIFont.systemFont(ofSize: 17.0, weight: weight)
    }
}
