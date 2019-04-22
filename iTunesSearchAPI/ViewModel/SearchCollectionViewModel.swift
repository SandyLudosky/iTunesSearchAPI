//
//  SearchCollectionViewModel.swift
//  iTunesSearchAPI
//
//  Created by Sandy Ludosky on 21/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import Foundation
import UIKit

struct SearchCollectionViewModel {
    let name: String
    let previewURL: String?
    let artwork: String?
    var image:UIImage?
    let dataController = DataController()
}

extension SearchCollectionViewModel {
    init(with result: Result) {
        self.name = result.trackName
        self.previewURL = result.previewURL
        self.artwork = result.artworkUrl60
    }
    
    func preview(with url: String, completion: @escaping (UIImage) -> Void) {
        dataController.download(with: url) { (data, error) in
            if error == nil {
                guard let imageData = data else { return }
                guard let img = (UIImage(data: imageData)) else { return }
                completion(img)
            }
        }
    }
}
