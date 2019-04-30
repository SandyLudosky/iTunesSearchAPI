//
//  Result.swift
//  iTunesSearchAPI
//
//  Created by Sandy Ludosky on 21/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import Foundation
import UIKit

//Enums
public enum WrapperType {
    case track, collection, artist
}
public enum Explicitness {
    case explicit, cleaned, notExplicit
}
public enum Kind {
    case book, album, coachedAudio, featureMovie, interactiveBooklet, musicVideo, pdf, podcast, podcastEpisode, softwarePackage, song, tvEpisode, artist
}

struct Result: Codable  {
    let trackName: String
    let artistName: String
    let collectionName: String
    let censoredName: String
    var viewURL: String
    let kind: String
    var explicit: String? 
    var wrapper: String?
    var artworkUrl100: String?
    var artworkUrl60: String?
    var previewURL: String?
    var trackTimeMillis: Int?
    var primaryGenreName: String?
    var contentAdvisoryRating: String?
    var image: UIImage?
}

extension Result {
    enum CodingKeys: String, CodingKey {
        // swiftlint:disable:next line_length
        case trackName, artistName, collectionName, censoredName = "trackCensoredName", artworkUrl100, artworkUrl60, viewURL = "trackViewUrl", previewURL = "previewUrl", trackTimeMillis, explicit = "trackExplicitness", wrapper = "wrapperType", kind, primaryGenreName, contentAdvisoryRating
    }
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        trackName = try values.decodeIfPresent(String.self, forKey: .trackName) ?? ""
        artistName = try values.decodeIfPresent(String.self, forKey: .artistName) ?? ""
        collectionName = try values.decodeIfPresent(String.self, forKey: .collectionName) ?? ""
        censoredName = try values.decodeIfPresent(String.self, forKey: .censoredName) ?? ""
        viewURL = try values.decodeIfPresent(String.self, forKey: .viewURL) ?? ""
        kind = try values.decodeIfPresent(String.self, forKey: .kind) ?? ""
        previewURL = try values.decodeIfPresent(String.self, forKey: .previewURL)
        explicit = try values.decodeIfPresent(String.self, forKey: .explicit)
        wrapper = try values.decodeIfPresent(String.self, forKey: .wrapper)
        artworkUrl60 = try values.decodeIfPresent(String.self, forKey: .artworkUrl60)
        artworkUrl100 = try values.decodeIfPresent(String.self, forKey: .artworkUrl100) ?? ""
        previewURL = try values.decodeIfPresent(String.self, forKey: .previewURL)
        trackTimeMillis = try values.decodeIfPresent(Int.self, forKey: .trackTimeMillis)
        primaryGenreName = try values.decodeIfPresent(String.self, forKey: .primaryGenreName)
        contentAdvisoryRating = try values.decodeIfPresent(String.self, forKey: .contentAdvisoryRating)
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(trackName, forKey: .trackName)
        try container.encode(artistName, forKey: .artistName)
        try container.encode(collectionName, forKey: .collectionName)
        try container.encode(censoredName, forKey: .censoredName)
        try container.encode(artworkUrl60, forKey: .artworkUrl60)
        try container.encode(artworkUrl100, forKey: .artworkUrl100)
        try container.encode(viewURL, forKey: .viewURL)
        try container.encode(previewURL, forKey: .previewURL)
        try container.encode(trackTimeMillis, forKey: .trackTimeMillis)
    }
}

extension Result {
    var explicitNess: Explicitness {
        return .explicit
    }
    var wrapperType: WrapperType {
        return .track
    }
    var kindType: Kind {
        return .song
    }
    var isExplicit: Bool {
        return false
    }
}
