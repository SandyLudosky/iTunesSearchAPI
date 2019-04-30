//
//  ResultDetailsProtocol.swift
//  iTunesSearchAPI
//
//  Created by Sandy Ludosky on 30/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import Foundation

typealias ResultDetailsHandler = (ResultDetailsViewModel?, ErrorHandler?) -> Void
protocol ResultDetailsViewProtocol {
    var presenter:ResultDetailsPresenterProtocol? { get set }
    func configureView()
}
protocol ResultDetailsPresenterProtocol {
    var interactor: ResultDetailsInteractorProtocol? { get set }
    func showResultDetail(for service: APIService,_ completion:  @escaping ResultDetailsHandler)
    func showResultDetail(for viewModel: ResultViewModel)
}
protocol ResultDetailsInteractorProtocol {
    func getResultDetails(for service: APIService,_ completion: @escaping ([Result]?, ErrorHandler?) -> Void)
}
protocol ResultDetailsAPIServiceProtocol {
    func getResults(_ completion: (Result) -> Void)
}


