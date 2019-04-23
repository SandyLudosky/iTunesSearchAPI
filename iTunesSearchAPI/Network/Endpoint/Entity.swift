//
//  Entity.swift
//  iTunesSearchAPI
//
//  Created by Sandy Ludosky on 23/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import Foundation

public protocol ItunesEntity: QueryItemProvider {
    var name: String { get }
}
extension ItunesEntity {
    public var queryItem: URLQueryItem {
        return URLQueryItem(name: "entity", value: name)
    }
}

public enum MovieEntity: String, ItunesEntity {
    case movieArtist
    case movie
    public var name: String {
        return self.rawValue
    }
}

public enum PodcastEntity: String, ItunesEntity {
    case podcastAuthor
    case podcast
    public var name: String {
        return self.rawValue
    }
}

public enum MusicEntity: String, ItunesEntity {
    case musicArtist
    case musicTrack
    case album
    case musicVideo
    case mix
    case song
    public var name: String {
        return self.rawValue
    }
}

public enum MusicVideoEntity: String, ItunesEntity {
    case musicArtist
    case musicVideo
    public var name: String {
        return self.rawValue
    }
}

public enum AudiobookEntity: String, ItunesEntity {
    case audiobookAuthor
    case audiobook
    public var name: String {
        return self.rawValue
    }
}

public enum ShortFilmEntity: String, ItunesEntity {
    case shortFilmArtist
    case shortFilm
    public var name: String {
        return self.rawValue
    }
}

public enum TVShowEntity: String, ItunesEntity {
    case tvEpisode
    case tvSeason
    public var name: String {
        return self.rawValue
    }
}

public enum SoftwareEntity: String, ItunesEntity {
    case software
    case iPadSoftware
    case macSoftware
    public var name: String {
        return self.rawValue
    }
}

public enum EbookEntity: String, ItunesEntity {
    case ebook
    public var name: String {
        return self.rawValue
    }
}

public enum AllEntity: String, ItunesEntity {
    case movie
    case album
    case allArtist
    case podcast
    case musicVideo
    case mix
    case audiobook
    case tvSeason
    case allTrack
    public var name: String {
        return self.rawValue
    }
}
