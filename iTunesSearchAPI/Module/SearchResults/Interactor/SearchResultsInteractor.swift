//
//  SearchResultsInteractor.swift
//  iTunesSearchAPI
//
//  Created by Sandy Ludosky on 29/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import Foundation

class SearchResultsInteractor: SearchResultsInteractorProtocol {
    let dataController = DataController()
    func getResults(with term: String, mediaType: Media?, country: Country?, _ completion: @escaping ([Result]?, ErrorHandler?) -> Void) {
        dataController.search(for: term, mediaType: mediaType, country: country) { results in
            switch results {
                case .success(let searchResults):
                    guard let r = searchResults as? [Result] else { return }
                    completion(r, nil)
                case .failure(let error):
                    completion(nil, error)
            }
        }
    }
}
