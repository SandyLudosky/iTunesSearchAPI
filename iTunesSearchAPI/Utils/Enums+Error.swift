//
//  Enums+Error.swift
//  iTunesSearchAPI
//
//  Created by Sandy Ludosky on 23/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import Foundation


public enum StatusCode {
    case clientError, serverError
}

extension StatusCode {
    var description: String {
        switch self {
        case .clientError: return "The item doesn’t exist"
        case .serverError: return "Server Error"
        }
    }
}

// MARK: Error

/// Enumeration listing `Oodrive` errors
public enum ErrorHandler: Error {
    case unknownError
    case invalidData
    case itemNotFound
    case itemInvalid
    case responseUnsuccessful
    case responseFailure(StatusCode, statusCode: Int)
    case requestFailed
    case jsonParsingFailure
    case invalidURL
}


// MARK: - LocalizedError
extension ErrorHandler: LocalizedError {
    
    /// A localized message describing what error occurred.
    public var errorDescription: String? {
        switch self {
        case .unknownError: return NSLocalizedString("Unknown error.", comment: "")
        case .itemNotFound:  return NSLocalizedString("Item not found.", comment: "")
        case .itemInvalid: return NSLocalizedString("Item invalid.", comment: "")
        case .invalidData: return NSLocalizedString("Invalid Data", comment: "")
        case .responseUnsuccessful: return NSLocalizedString("Unsuccessful Response", comment: "")
        case .responseFailure(let statusCode, let code): return NSLocalizedString("\(statusCode) - status code: \(code)", comment: "")
        case .requestFailed: return NSLocalizedString("Request Failed", comment: "")
        case .jsonParsingFailure: return NSLocalizedString("Error Parsing JSON", comment: "")
        case .invalidURL: return NSLocalizedString("Invalid URL", comment: "")
        }
    }
    
    /// A localized message describing the reason for the failure.
    public var failureReason: String? {
        switch self {
        case .unknownError: return NSLocalizedString("Error code is not referenced.", comment: "")
        case .itemNotFound:  return NSLocalizedString("The item doesn’t exist.", comment: "")
        case .itemInvalid: return NSLocalizedString("Invalid item name or type", comment: "")
        case .invalidData: return NSLocalizedString("Invalid Data", comment: "")
        case .responseUnsuccessful: return NSLocalizedString("Unsuccessful Response", comment: "")
        case .responseFailure(let statusCode): return NSLocalizedString("Response Failure - status code \(statusCode)", comment: "")
        case .requestFailed: return NSLocalizedString("Request Failed", comment: "")
        case .jsonParsingFailure: return NSLocalizedString("Error Parsing JSON", comment: "")
        case .invalidURL: return NSLocalizedString("Invalid URL", comment: "")
        }
    }
    
    /// A localized message describing how one might recover from the failure.
    public var recoverySuggestion: String? {
        switch self {
        case .unknownError: return NSLocalizedString("Please try later.", comment: "")
        case .itemNotFound:  return NSLocalizedString("Please provide valid item's identifier.", comment: "")
        case .itemInvalid: return NSLocalizedString("Please provide a valid item.", comment: "")
        case .invalidData: return NSLocalizedString("Check Data", comment: "")
        case .responseUnsuccessful: return NSLocalizedString("Unsuccessful Response", comment: "")
        case .responseFailure(_): return NSLocalizedString("Debugging = Check Status Code", comment: "")
        case .requestFailed: return NSLocalizedString("Please Check Request Attributes", comment: "")
        case .jsonParsingFailure: return NSLocalizedString("Please Check JSON response format", comment: "")
        case .invalidURL: return NSLocalizedString("Please Check if URL format is well structured as per iTunes API Documentation", comment: "")
        }
    }
    
    /// A localized message providing "help" text if the user requests help.
    public var helpAnchor: String? {
        switch self {
        case .unknownError: return NSLocalizedString("Please contact developer.", comment: "")
        case .itemNotFound:  return NSLocalizedString("Please check your item's identifier.", comment: "")
        case .itemInvalid: return NSLocalizedString("Please check your item name or type.", comment: "")
        case .invalidData: return NSLocalizedString("Please Check Data", comment: "")
        case .responseUnsuccessful: return NSLocalizedString("Please Debug Response", comment: "")
        case .requestFailed: return NSLocalizedString("Please Check Request Attributes", comment: "")
        case .jsonParsingFailure: return NSLocalizedString("Please Check JSON response format", comment: "")
        case .responseFailure(let statusCode, let code): return NSLocalizedString("\(statusCode) - status code: \(code)", comment: "")
        case .invalidURL: return NSLocalizedString("Invalid URL", comment: "")
        }
    }
}
