//
//  ViewModelFacade.swift
//  iTunesSearchAPI
//
//  Created by Sandy Ludosky on 20/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import Foundation

typealias Handler = (ResultObject<Any>) -> Void
typealias DataHandler = (Data?, Error?) -> Void
protocol DataControllerProtocol {
    func search(for term: String, mediaType: Media?, country: Country?, completion: @escaping Handler)
    func lookup(with id: String, entity: ItunesEntity?, completion: @escaping Handler)
    func download(with url: String, completion: @escaping DataHandler)
}
class DataController {
    let client = APIClient<APIService>()
}

extension DataController: DataControllerProtocol {
    func search(for term: String, mediaType: Media?, country: Country?, completion: @escaping Handler) {
        client.get(with: .search(term: term, media: mediaType, country: country)) { results in
            switch results {
            case .array(_), .data(_): break
            case .dict(let dict):
                guard let results = dict["results"] as? [[String : Any]] else {
                    return
                }
                let searchResults = try? results.map({ dict -> Result in
                    guard let data = try? JSONSerialization.data(withJSONObject: dict, options: []) else {
                        throw ErrorHandler.invalidData
                    }
                   return try JSONDecoder().decode(Result.self, from: data)
                })
                DispatchQueue.main.async {
                    completion(.success(searchResults ?? []))
                }
            case .error(let reason): completion(.failure(reason))
            }
        }
    }
    
    func lookup(with id: String, entity: ItunesEntity?, completion: @escaping Handler) {
        client.get(with: .lookup(id: id, entity: entity)) { results in
            switch results {
            case .array(_), .data(_): break
            case .dict(let dict):
                guard let results = dict["results"] as? [[String : Any]] else {
                    return
                }
                let searchResults = try? results.map({ dict -> Result in
                    guard let data = try? JSONSerialization.data(withJSONObject: dict, options: []) else {
                        throw ErrorHandler.invalidData
                    }
                    return try JSONDecoder().decode(Result.self, from: data)
                })
                DispatchQueue.main.async {
                    completion(.success(searchResults ?? []))
                }
            case .error(let reason): completion(.failure(reason))
            }
        }
    }
    
    func download(with url: String, completion: @escaping DataHandler) {
        return client.get(with: .download(url: url)) { result in
            switch result {
            case .array(_), .dict(_): break
            case .data(let data):
                if let dataValid = data as? Data {
                    _ = completion(dataValid, nil)
                }
            case .error(let reason): completion(nil, reason)
            }
        }
    }
}
