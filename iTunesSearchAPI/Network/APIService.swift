//
//  APIService.swift
//  iTunesSearchAPI
//
//  Created by Sandy Ludosky on 20/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import Foundation

public enum APIService: APIProtocol {
    case search(term: String, media: Media?, country: Country?)
    case lookup(id: String, entity: ItunesEntity?) //for ID-based lookups artistID/AMG ArtistID/UPC/EANs...
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
}

extension APIService {
    public var request: URLRequest? {
        var queryItems = [URLQueryItem]()
        
        switch self {
        case .search(let term, let media, let country):
            queryItems.append(URLQueryItem(name: "term", value: term))
            queryItems.append(URLQueryItem(name: "country", value: country?.abbreviation))
            
            if let media = media {
                queryItems.append(URLQueryItem(name: "media", value: media.description))
                
                if let entityQueryItem = media.entityQueryItem {
                    queryItems.append(entityQueryItem)
                    print(entityQueryItem)
                }
                
            
                if let attributeQueryItem = media.attributeQueryItem {
                    queryItems.append(attributeQueryItem)
                       print(attributeQueryItem)
                }
                
              
            }
        case .lookup(let id, let entity):
            queryItems.append(URLQueryItem(name: "id", value: id))
            if let entityName = entity?.name {
                queryItems.append(URLQueryItem(name: "entity", value:  entityName))
            }
        default: break
        }
        
        guard let urlRequest = try? asURLRequest(queryItems: queryItems) else {
            return nil
        }
        return urlRequest
    }
}
