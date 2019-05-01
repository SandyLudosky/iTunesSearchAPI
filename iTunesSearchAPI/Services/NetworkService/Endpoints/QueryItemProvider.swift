//
//  QueryItemProvider.swift
//  iTunesSearchAPI
//
//  Created by Sandy Ludosky on 23/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import Foundation

public protocol QueryItemProvider {
    var queryItem: URLQueryItem { get }
}
