//
//  ViewModelFacade.swift
//  iTunesSearchAPI
//
//  Created by Sandy Ludosky on 20/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import Foundation

typealias Handler = (ResultObject<Any>) -> Void
protocol DataManagerProtocol {
    func get(for service: APIService, completion: @escaping Handler)
}
class DataManagerService {
    let client = APIClient<APIService>()
}
extension DataManagerService: DataManagerProtocol {
    func get(for service: APIService, completion: @escaping Handler) {
        client.get(with: service) { results in
            switch results {
            case .data(let data):
                if let dataValid = data as? Data {
                   completion(.success(dataValid))
                }
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
            case .array(_) : break
            case .error(let reason): completion(.failure(reason))
            }
        }
    }
}

