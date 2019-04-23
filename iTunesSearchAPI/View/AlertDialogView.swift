//
//  AlertDialogView.swift
//  iTunesSearchAPI
//
//  Created by Sandy Ludosky on 23/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import Foundation
import UIKit

class AlertDialogView {
    static func build(with message: String, vc: UIViewController) {
        let alert = UIAlertController(title: "Error Message", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
       // alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
       vc.present(alert, animated: true)
    }
}
