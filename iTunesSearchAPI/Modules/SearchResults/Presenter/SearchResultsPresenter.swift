//
//  SearchResultsPresenter.swift
//  iTunesSearchAPI
//
//  Created by Sandy Ludosky on 29/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import Foundation


class SearchResultsPresenter : SearchResultsPresenterProtocol {
    var interactor: SearchResultsInteractorProtocol?
    var router: SearchResultsRouterProtocol?

    func showResults(for service: APIService, _ completion: @escaping ResultHandler) {
        interactor?.getResults(for: service, { (results, error) in
            if error == nil {
                guard let r = results else { return }
                let resultsViewModel = r.map({ result -> ResultViewModel in
                    return ResultViewModel(trackName: result.trackName, artistName: result.artistName, previewURL: result.previewURL ?? "", artwork: result.artworkUrl60 ?? "")
                })
                completion(resultsViewModel, nil)
            } else {
                completion(nil, error)
            }
        })
    }
    
    func showResultDetail(for viewModel: ResultViewModel) {
        router?.showResultDetail(for: viewModel)
    }
}
