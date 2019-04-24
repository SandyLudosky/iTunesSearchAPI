//
//  WelcomeViewController.swift
//  iTunesSearchAPI
//
//  Created by Sandy Ludosky on 22/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    var action: Action?
    @IBAction func selectionAction(_ sender: UIButton) {
        switch sender.tag {
            case 1: action = .search
            case 2: action = .lookUp
            default: break
        }
        performSegue(withIdentifier: "goToSearch", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Navigation
extension WelcomeViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSearch" {
            if let navController = segue.destination as? UINavigationController {
                if let searchResultController = navController.viewControllers.first as? SearchResultsViewController {
                    searchResultController.action = action
                }
            }
        }
    }
}
