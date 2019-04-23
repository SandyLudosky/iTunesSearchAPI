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
    
    // MARK: - Lifecycle
    
    /// Called when a designable object is created in Interface Builder.
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        design()
    }
    
    /// Initializes and returns a newly allocated view object with the specified frame rectangle.
    public override init(frame: CGRect) {
        super.init(frame: frame)
        design()
    }
    
    /// Initializes and returns a newly allocated view object from decoder.
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        design()
    }
    
    /// Implemented by subclasses to initialize a new object immediately after memory for it has been allocated.
    public convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 375, height: 40))
    }
    
    // MARK: - Design
    
    /// Design `UIButton` at design and run time.
    open func design() {
        // TODO: Make global configuration here.
        clipsToBounds = true
        layer.cornerRadius = 20
        layer.borderColor = Color.info.cgColor
        layer.borderWidth = 1.0
        self.titleLabel?.font = Styles.Button.normal
        self.setTitleColor(Color.info, for: .normal)
    }
    
}
