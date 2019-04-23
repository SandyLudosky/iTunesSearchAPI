//
//  Label.swift
//  iTunesSearchAPI
//
//  Created by Sandy Ludosky on 23/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import UIKit

/**
 `UILabel` subclass
 
 View that displays one or more lines of read-only text,
 often used in conjunction with controls to describe their intended purpose.
 
 [Apple's documentation for UILabel](https://developer.apple.com/documentation/uikit/uilabel)
 
 - note: This component can be rendered at design time
 - requires: `UIKit`
 */

@IBDesignable
open class Label: UILabel {
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        design()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        design()
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        design()
    }
    open func design() {
        textColor = Color.info
        font = Styles.Label.title
    }
}

@IBDesignable
open class TitleLabel: Label {
    open override func design() {
        textColor = Color.concreteColor
        font = Styles.Label.title
    }
}

@IBDesignable
open class SubTitleLabel: Label {
    open override func design() {
        textColor = Color.silverColor
        font = Styles.Label.subtitle
    }
}
