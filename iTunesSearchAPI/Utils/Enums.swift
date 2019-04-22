//
//  Enums.swift
//  iTunesSearchAPI
//
//  Created by Sandy Ludosky on 20/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import Foundation

public enum Action {
    case search, lookUp
}

public enum Country: String {
    case france, us
}

public enum MediaType: String {
    case movie
    case podcast
    case music
    case musicVideo
    case audiobook
    case shortFilm
    case tvShow
    case software
    case ebook
    case all
}

public enum Entity {
    case movie(Movie)
    case podcast(PodCast)
    case music(Music)
    case musicVideo(MusicVideo)
    case audiobook(AudioBook)
    case shortFilm(ShortFilm)
    case tvShow(TvShow)
    case software(type: Software)
    case ebook(type: Ebook)
    case all(type: All)
    
    var string: String {
        switch self {
        case .movie(let type): return type.rawValue
        case .podcast(let type): return type.rawValue
        case .music(let type): return type.rawValue
        case .musicVideo(let type): return type.rawValue
        case .audiobook(let type): return type.rawValue
        case .shortFilm(let type): return type.rawValue
        case .tvShow(let type): return type.rawValue
        case .software(let type): return type.rawValue
        case .ebook(let type): return type.rawValue
        case .all(let type): return type.rawValue
        }
    }

}

public enum Movie: String {
   case movieArtist, movie
}

public enum PodCast: String {
    case podcastAuthor, podcast
}

public enum Music: String {
    case musicArtist, musicTrack, album, musicVideo, mix, song
}

public enum MusicVideo: String {
   case musicArtist, musicVideo
}

public enum AudioBook: String {
    case audiobookAuthor, audiobook
}

public enum ShortFilm: String {
    case shortFilmArtist, shortFilm
}

public enum TvShow: String {
    case tvEpisode, tvSeason
}

public enum Software: String {
    case software, iPadSoftware, macSoftware
}

public enum Ebook: String {
    case ebook
}

public enum All: String {
    case movie, album, allArtist, podcast, musicVideo, mix, audiobook, tvSeason, allTrack
}
