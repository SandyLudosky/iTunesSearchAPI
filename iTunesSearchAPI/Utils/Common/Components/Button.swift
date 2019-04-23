//
//   TODO: Make global configuration here.     clipsToBounds = true     layer.swift
//  iTunesSearchAPI
//
//  Created by Sandy Ludosky on 23/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import UIKit

@IBDesignable
open class Button: UIButton {
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
    
    public convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 375, height: 40))
    }
    
    open func design() {
        clipsToBounds = true
        layer.cornerRadius = 20
        layer.borderColor = Color.info.cgColor
        layer.borderWidth = 1.0
        self.titleLabel?.font = Styles.Button.normal
        self.setTitleColor(Color.info, for: .normal)
    }
    
}
