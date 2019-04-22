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
    case lookup(id: String, entity: Entity?) //look up with either id, artistID, AMG ArtistID, UPC ...
    case download(url: String) //to download media
    
    public var baseURL: String {
        switch self {
        case .search, .lookup: return "https://itunes.apple.com/"
        case .download(let url) : return url
        }
    }
    public var endpoint: String {
        switch self {
        case .search:
            return "search"
        case .lookup:
            return "lookup"
        case .download(_ ):
            return ""
        }
    }
    
    public var parameter: String? {
        switch self {
        case .search(let term,_ ,_ ,_ ): return term
        case .lookup(let id,_ ): return id
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
        guard let urlStr = URL(string: baseURL) else {
            //non fatal error
            fatalError("url not valid")
        }
        guard var components = URLComponents(url: urlStr.appendingPathComponent(endpoint), resolvingAgainstBaseURL: false) else {
            return nil
        }
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
        
        components.queryItems = queryItems
        guard let url = components.url else {
            return nil
        }
        
        let stringURL = "\(url)"
        let allowedCharacterSet = (CharacterSet(charactersIn: "%").inverted)
        guard let encodedString = stringURL.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) else {
            fatalError("Unable to encode url")
        }
        return URLRequest(url: URL(string: encodedString)!)
    }
}
