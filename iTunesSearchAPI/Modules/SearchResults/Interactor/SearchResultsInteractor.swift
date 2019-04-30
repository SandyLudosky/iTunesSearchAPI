//
//  SearchResultsInteractor.swift
//  iTunesSearchAPI
//
//  Created by Sandy Ludosky on 29/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import Foundation

class SearchResultsInteractor: SearchResultsInteractorProtocol {
    let dataManager = DataManagerService()
    func getResults(for service: APIService, _ completion: @escaping ([Result]?, ErrorHandler?) -> Void) {
        dataManager.get(for: service) { results in
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
