//
//  APIProtocol.swift
//  iTunesSearchAPI
//
//  Created by Sandy Ludosky on 20/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import Foundation

public protocol APIProtocol {
    var baseURL: String { get }
    var endpoint: String { get } // required
    var country: Country? { get } //required
    var media: MediaType? { get } //optional
    var entity: Entity? { get } //optional
    var request: URLRequest? { get }
}

extension APIProtocol {
    func asURLRequest(queryItems: [URLQueryItem]) throws -> URLRequest? {
        
        //baseURL + endpoints
        guard let urlStr = URL(string: baseURL),
        var components = URLComponents(url: urlStr.appendingPathComponent(endpoint), resolvingAgainstBaseURL: false)
        else { throw ErrorHandler.encodingError }
        
        //parameters
        components.queryItems = queryItems
        
        // encoded URL
        guard let url = components.url,
        let encodedURL = url.encode(),
        let request =  URLRequest(url: encodedURL) as? URLRequest
        else { throw ErrorHandler.invalidRequest }
        return request
    }
}
