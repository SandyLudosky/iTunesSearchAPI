//
//  SearchResultsRouter.swift
//  iTunesSearchAPI
//
//  Created by Sandy Ludosky on 29/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import Foundation
import UIKit

class SearchResultsRouter: SearchResultsRouterProtocol {
    var viewController: UIViewController?
    var navController: UINavigationController?
    
    func showResultDetail(for viewModel: ResultViewModel) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let navigationController = viewController?.navigationController else { return }
        guard let viewController = storyboard.instantiateViewController(withIdentifier: " ResultDetailsViewController") as?  ResultDetailsViewController else { return }
         viewController.vm = viewModel
         navigationController.pushViewController(viewController, animated: true)
    }
}
