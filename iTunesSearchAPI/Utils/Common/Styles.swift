//
//  Styles.swift
//  iTunesSearchAPI
//
//  Created by Sandy Ludosky on 23/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import UIKit

struct Styles {
    // MARK: UIButton
    struct Button {
        static var normal: UIFont = Fonts.Roboto.bold.withSize(18.0)
        static var highlighted: UIFont = Fonts.Roboto.bold.withSize(18.0)
        static var disabled: UIFont = Fonts.Roboto.bold.withSize(18.0)
    }
    // MARK: UILabel
    struct Label {
        static var title: UIFont = Fonts.System.semibold.withSize(18.0)
        static var subtitle: UIFont = Fonts.System.semibold.withSize(15.0)
    }
}
