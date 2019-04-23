//
//  Enums+Network.swift
//  iTunesSearchAPI
//
//  Created by Sandy Ludosky on 22/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import Foundation

public enum ResultType<T> {
    case array([T])
    case data(T)
    case dict([String: Any])
    case error(ErrorHandler)
}
public enum ResponseType {
    case success(Data)
    case failure(ErrorHandler)
}
public enum ResultObject<T> {
    case success(T) 
    case failure(ErrorHandler)
}
