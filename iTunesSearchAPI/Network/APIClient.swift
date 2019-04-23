//
//  APIClient.swift
//  iTunesSearchAPI
//
//  Created by Sandy Ludosky on 20/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import Foundation

class APIClient<T: APIProtocol> {
    typealias ResponseHandler = (ResponseType) -> Void
    public typealias ResultHandler = (ResultType<Any>) -> Void
    func get(with service: T, completion: @escaping ResultHandler) {
        let task = runTask(with: service) { response in
            
            switch response {
            case .success(let data):
                JSONParser.parse(data, completion: { results in
                    switch results {
                    case .array(let arr):
                        completion(.array(arr))
                    case .dict(let dict):
                        completion(.dict(dict))
                    case .data(let data):
                        completion(.data(data))
                    case .error(let err):
                        completion(.error(err))
                    }
                })
            case .error(let error): completion(.error(error))
            }
            
        }
        task?.resume()
    }
}

private extension APIClient {
    //handle response and data
    private func runTask(with service: APIProtocol, completion: @escaping ResponseHandler) -> URLSessionDataTask? {
        print("URL : \(service.request!.url!)")
        guard let request = service.request else {
            return nil
        }
        return URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if error == nil {
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.error(.responseUnsuccessful))
                    return
                }
                
                switch httpResponse.statusCode {
                    case 400...499: completion(.error(.responseFailure(.clientError, statusCode: httpResponse.statusCode)))
                    case  500 ... 599 : completion(.error(.responseFailure(.serverError, statusCode: httpResponse.statusCode)))
                    case 200 ... 299:
                        guard let data = data else {
                            completion(.error(.invalidData))
                            return
                        }
                        completion(.success(data))
                    default : break
                }
            }
        })
    }
}
