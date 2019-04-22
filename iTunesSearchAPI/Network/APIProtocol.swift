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
