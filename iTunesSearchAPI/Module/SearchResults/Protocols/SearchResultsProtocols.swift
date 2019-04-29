//
//  SearchResultsProtocols.swift
//  iTunesSearchAPI
//
//  Created by Sandy Ludosky on 29/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import Foundation
import UIKit

typealias ResultHandler = ([ResultViewModel]?, ErrorHandler?) -> Void

protocol SearchResultsViewProtocol {
    var presenter: SearchResultsPresenterProtocol? { get set }
    func setup()
}
protocol SearchResultsPresenterProtocol {
    var interactor: SearchResultsInteractorProtocol? { get set }
    var router: SearchResultsRouterProtocol? { get set }
    func showResults(for service: APIService,_ completion:  @escaping ResultHandler)
    func showResultDetail(for viewModel: ResultViewModel)
}
protocol SearchResultsInteractorProtocol {
    func getResults(for service: APIService,_ completion: @escaping ([Result]?, ErrorHandler?) -> Void)
}
protocol SearchResultsAPIServiceProtocol {
    func getResults(_ completion: (Result) -> Void)
}
protocol SearchResultsRouterProtocol {
    var viewController: UIViewController? { get set }
    func showResultDetail(for viewModel: ResultViewModel)
}

