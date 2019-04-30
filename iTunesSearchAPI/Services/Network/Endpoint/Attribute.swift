//
//  Attribute.swift
//  iTunesSearchAPI
//
//  Created by Sandy Ludosky on 23/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import Foundation

protocol ItunesAttribute: QueryItemProvider {
    var name: String { get }
}

extension ItunesAttribute {
    public var queryItem: URLQueryItem {
        return URLQueryItem(name: "attribute", value: name)
    }
}

public enum MovieAttribute: String, ItunesAttribute {
    case actorTerm
    case genreIndex
    case artistTerm
    case shortFilmTerm
    case producerTerm
    case ratingTerm
    case directorTerm
    case releaseYearTerm
    case featureFilmTerm
    case movieArtistTerm
    case movieTerm
    case ratingIndex
    case descriptionTerm
    
    var name: String {
        return self.rawValue
    }
}

public enum PodcastAttribute: String, ItunesAttribute {
    case titleTerm
    case languageTerm
    case authorTerm
    case genreIndex
    case artistTerm
    case ratingIndex
    case keywordsTerm
    case descriptionTerm
    
    var name: String {
        return self.rawValue
    }
}

public enum MusicAttribute: String, ItunesAttribute {
    case mixTerm
    case genreIndex
    case artistTerm
    case composerTerm
    case albumTerm
    case ratingIndex
    case songTerm
    
    var name: String {
        return self.rawValue
    }
}

public enum MusicVideoAttribute: String, ItunesAttribute {
    case genreIndex
    case artistTerm
    case albumTerm
    case ratingIndex
    case songTerm
    
    var name: String {
        return self.rawValue
    }
}

public enum AudiobookAttribute: String, ItunesAttribute {
    case titleTerm
    case authorTerm
    case genreIndex
    case ratingIndex
    
    var name: String {
        return self.rawValue
    }
}

public enum ShortFilmAttribute: String, ItunesAttribute {
    case genreIndex
    case artistTerm
    case shortFilmTerm
    case ratingIndex
    case descriptionTerm
    
    var name: String {
        return self.rawValue
    }
}

public enum SoftwareAttribute: String, ItunesAttribute {
    case softwareDeveloper
    
    var name: String {
        return self.rawValue
    }
}

public enum TVShowAttribute: String, ItunesAttribute {
    case genreIndex
    case tvEpisodeTerm
    case showTerm
    case tvSeasonTerm
    case ratingIndex
    case descriptionTerm
    
    var name: String {
        return self.rawValue
    }
}

public enum AllAttribute: String, ItunesAttribute {
    case actorTerm
    case languageTerm
    case allArtistTerm
    case tvEpisodeTerm
    case shortFilmTerm
    case directorTerm
    case releaseYearTerm
    case titleTerm
    case featureFilmTerm
    case ratingIndex
    case keywordsTerm
    case descriptionTerm
    case authorTerm
    case genreIndex
    case mixTerm
    case allTrackTerm
    case artistTerm
    case composerTerm
    case tvSeasonTerm
    case producerTerm
    case ratingTerm
    case songTerm
    case movieArtistTerm
    case showTerm
    case movieTerm
    case albumTerm
    
    var name: String {
        return self.rawValue
    }
}
