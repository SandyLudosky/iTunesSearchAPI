//
//  ViewMOdel.swift
//  iTunesSearchAPI
//
//  Created by Sandy Ludosky on 21/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import Foundation

protocol SearchResultViewModelProtocol {
    func fetch(term: String, country: Country?, type: MediaType?, entity: Entity?, completion: @escaping (Error?) -> ())
}
class SearchResultViewModel {
    let dataController = DataController()
    var data: [Result]?
}

extension SearchResultViewModel: SearchResultViewModelProtocol {
    func fetch(term: String, country: Country?, type: MediaType?, entity: Entity?, completion: @escaping (Error?) -> ()) {
        dataController.search(for: term, country: nil, type: type, entity: entity) { results in
            switch results {
            case .success(let array):
                guard let arr = array as? [Result] else {
                    return
                }
                DispatchQueue.main.async {
                    self.data = arr
                    completion(nil)
                }
            case .error(let err):  completion(err)
            }
        }
    }

}
