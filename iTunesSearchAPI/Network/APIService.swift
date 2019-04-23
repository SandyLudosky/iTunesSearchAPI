//
//  APIService.swift
//  iTunesSearchAPI
//
//  Created by Sandy Ludosky on 20/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import Foundation

//https://itunes.apple.com/search?parameterkeyvalue
public enum APIService: APIProtocol {
    case search(term: String, country: Country?, media: MediaType?, entity: Entity?)
    case lookup(id: String, entity: Entity?) //for ID-based lookups artistID/AMG ArtistID/UPC/EANs...
    case download(url: String) //to download media
    
    public var baseURL: String {
        switch self {
        case .search, .lookup: return "https://itunes.apple.com/"
        case .download(let url) : return url //media full url - no parameters
        }
    }
    public var endpoint: String {
        switch self {
        case .search: return "search"
        case .lookup: return "lookup"
        case .download(_ ): return ""
        }
    }
    
    //either text or id
    public var parameter: String? {
        switch self {
        case .search(let term,_ ,_ ,_ ): return term
        case .lookup(let id,_ ): return id //ID-based lookups artistID/AMG ArtistID/UPC/EANs...
        case .download: return nil
        }
    }
    
    public var country: Country? {
        switch self {
        case .search(_ , let country,_ , entity:_ ): return country
        case .lookup, .download: return nil
        }
    }
    
    public var media: MediaType? {
        switch self {
        case .search(_ ,_ , let media,_ ): return media
        case .lookup, .download: return nil
        }
    }
    
    public var entity: Entity? {
        switch self {
        case .search(_ ,_ ,_ , let entity),
             .lookup(_, let entity):
            return entity
        case .download: return nil
        }
    }
    
}

extension APIService {
    public var request: URLRequest? {
        var queryItems = [URLQueryItem]()
       
        //url parameters
        switch self {
            case .search:
    
                queryItems.append(URLQueryItem(name: "term", value: parameter))
                queryItems.append(URLQueryItem(name: "country", value: country?.rawValue))
                if let mediaType = media?.rawValue {
                     queryItems.append(URLQueryItem(name: "media", value: mediaType))
                }
                if let entityType = entity?.string {
                     queryItems.append(URLQueryItem(name: "entity", value: entityType))
                }
            case .lookup:
               queryItems.append(URLQueryItem(name: "id", value: parameter))
               if let entityType = entity?.string {
                queryItems.append(URLQueryItem(name: "entity", value: entityType))
            }
            default: break
        }
        
        return try! asURLRequest(queryItems: queryItems) 
    }
}
