//
//  ResultDetailsViewModel.swift
//  iTunesSearchAPI
//
//  Created by Sandy Ludosky on 23/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import Foundation
import UIKit

protocol ResultDetailsViewModelProtocol {
    func displayDetails(with result: Result, completion: () -> Void)
    func loadArtwork(completion: @escaping (UIImage?) -> Void)
    func loadPreview()
}

class ResultDetailsViewModel {
    let dataController = DataController()
    var result: Result?
    var request: URLRequest?
    var artwork: UIImage?
}

extension ResultDetailsViewModel : ResultDetailsViewModelProtocol {
    func loadArtwork(completion: @escaping (UIImage?) -> Void) {
        guard let artwork = result?.artworkUrl60 else { return }
        dataController.download(with: artwork ) { (data, error) in
            if error == nil {
                guard let imageData = data else { return }
                guard let img = UIImage(data: imageData) else { return }
                DispatchQueue.main.async {
                    completion(img)
                }
            }
        }
    }
    
    func displayDetails(with r: Result, completion: () -> Void) {
        result = r
        loadPreview()
        completion()
    }
    
    func loadPreview()  {
        if let preview = result?.previewURL {
            guard let url = URL(string: preview) else { return }
            request = URLRequest(url: url)
        }
    }
}
