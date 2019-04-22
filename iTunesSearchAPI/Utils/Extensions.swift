//
//  Extensions.swift
//  iTunesSearchAPI
//
//  Created by Sandy Ludosky on 22/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import Foundation

extension URL {
    func encode() -> URL? {
        let stringURL = "\(self)"
        let allowedCharacterSet = (CharacterSet(charactersIn: "%").inverted)
        guard let encodedString = stringURL.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) else {
            return nil
        }
        guard let encodedURL = URL(string: encodedString) else {
            return nil
        }
        return encodedURL
    }
}
