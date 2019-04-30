//
//  ResultDetailsProtocol.swift
//  iTunesSearchAPI
//
//  Created by Sandy Ludosky on 30/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import Foundation


typealias ResultDetailsHandler = (ResultDetailsViewModel?, ErrorHandler?) -> Void
typealias ImageDataHandler = (Data?, ErrorHandler?) -> Void
typealias PreviewURLHandler = (URL?, ErrorHandler?) -> Void

protocol ResultDetailsViewProtocol {
    var presenter:ResultDetailsPresenterProtocol? { get set }
    func setUp()
    func configureView()
    func showResultDetails()
}
protocol ResultDetailsPresenterProtocol {
    var interactor: ResultDetailsInteractorProtocol? { get set }
    var viewModelDetails: ResultDetailsViewModel?  { get set }
    func showResultDetail(for viewModel: ResultViewModel, completion: @escaping () -> ())
}
protocol ResultDetailsInteractorProtocol {

    func loadArtwork(with url: String,_ completion: @escaping ImageDataHandler)
    func loadPreview(with url: String,_ completion: @escaping PreviewURLHandler)
}

protocol ResultDetailsAPIServiceProtocol {
    func getResults(_ completion: (Result) -> Void)
}


