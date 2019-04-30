//
//  SearchCollectionViewModel.swift
//  iTunesSearchAPI
//
//  Created by Sandy Ludosky on 21/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import Foundation
import UIKit

struct SearchCellViewModel {
    let name: String
    let artist: String
    let previewURL: String?
    let artwork: String?
    var image:UIImage?
    let dataManager = DataManagerService()
}
extension SearchCellViewModel {
    init(with result: ResultViewModel) {
        self.name = result.trackName
        self.artist = result.artistName
        self.previewURL = result.previewURL
        self.artwork = result.artwork
    }
    func preview(with url: String, completion: @escaping (UIImage?, ErrorHandler?) -> Void) {
        dataManager.get(for: .download(url: url)) {  result in
            switch result {
            case .success(let data):
                guard let imageData = data as? Data else { return }
                guard let img = (UIImage(data: imageData)) else {
                    completion(UIImage(named: "placeholder-120x120"), nil)
                    return
                }
                completion(img, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
