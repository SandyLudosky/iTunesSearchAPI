//
//  Fonts.swift
//  iTunesSearchAPI
//
//  Created by Sandy Ludosky on 23/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import UIKit

/// This structure holds fonts available for the whole application.
struct Fonts {
    
    /// Structure holding `Roboto` fonts
    struct Roboto {
        
        /// Regular `Roboto` font face.
        static var regular: UIFont = Fonts.font("Roboto-Regular")
        
        /// Black `Roboto` font face.
        static var black: UIFont = Fonts.font("Roboto-Black")
        
        /// Bold `Roboto` font face.
        static var bold: UIFont = Fonts.font("Roboto-Bold")
        
        /// Light `Roboto` font face.
        static var light: UIFont = Fonts.font("Roboto-Light")
        
        /// Medium `Roboto` font face.
        static var medium: UIFont = Fonts.font("Roboto-Medium")
        
        /// Thin `Roboto` font face.
        static var thin: UIFont = Fonts.font("Roboto-Thin")
        
        /// Structure holding italic `Roboto` fonts
        struct Italic {
            
            /// Regular `Roboto` italic font face.
            static var regular: UIFont = Fonts.font("Roboto-Italic")
            
            /// Black `Roboto` italic font face.
            static var black: UIFont = Fonts.font("Roboto-BlackItalic")
            
            /// Bold `Roboto` italic font face.
            static var bold: UIFont = Fonts.font("Roboto-BoldItalic")
            
            /// Light `Roboto` italic font face.
            static var light: UIFont = Fonts.font("Roboto-LightItalic")
            
            /// Medium `Roboto` italic font face.
            static var medium: UIFont = Fonts.font("Roboto-MediumItalic")
            
            /// Thin `Roboto` italic font face.
            static var thin: UIFont = Fonts.font("Roboto-ThinItalic")
        }
    }
    
    /// Structure holding `HelveticNeue` fonts
    struct HelveticaNeue {
        
        /// Regular `HelveticaNeue` font face.
        static var regular: UIFont = Fonts.font("HelveticaNeue")
        
    }
    
    /// Structure holding `System` fonts
    struct System {
        
        /// Semibold `System` italic font face.
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
