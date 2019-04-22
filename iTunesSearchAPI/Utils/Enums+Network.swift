//
//  Enums+Network.swift
//  iTunesSearchAPI
//
//  Created by Sandy Ludosky on 22/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import Foundation

public enum ErrorHandler: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case responseFailure(statusCode: Int)
    case invalidURL
    case jsonParsingFailure
    var description: String {
        switch self {
        case .requestFailed: return "request failed"
        case .jsonConversionFailure: return "json conversion failure"
        case .invalidData: return "invalid Data"
        case .jsonParsingFailure: return "json parsing failure"
        case .invalidURL: return "invalid Url"
        case .responseUnsuccessful: return "response Unsucessful"
        case .responseFailure(let statusCode): return "response Failure - status code \(statusCode)"
        }
    }
}

public enum StatusCode {
    case clientError400, clientError404
    var description: String {
        switch self {
        case .clientError400:
            return "Invalid name or an item with this name already exists."
        case .clientError404:
            return "The item doesn’t exist"
        }
    }
}

//network error handler
public enum ResultType<T> {
    case array([T])
    case dict([String: Any])
    case data(T)
    case error(ErrorHandler)
}

public enum ResponseType {
    case success(Data) // returns data if successful
    case error(ErrorHandler)
    case err(Error)
}

public enum ResultObject<T> {
    case success(T) // returns data if successful
    case error(ErrorHandler)
}
