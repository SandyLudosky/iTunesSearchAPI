//
//  ResultDetailsInteractor.swift
//  iTunesSearchAPI
//
//  Created by Sandy Ludosky on 30/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import Foundation
import UIKit

class ResultDetailsInteractor: ResultDetailsInteractorProtocol {
    let dataController = DataManagerService()

    func loadPreview(with url: String, _ completion: @escaping PreviewURLHandler) {
        guard let preview = URL(string: url) else {
            completion(nil, .invalidData)
            return
        }
        completion(preview, nil)
    }
    
    func loadArtwork(with url: String, _ completion: @escaping ImageDataHandler) {
        dataController.download(with: url) { (data, error)  in
            if error == nil {
                DispatchQueue.main.async {
                    guard let imageData = data else {
                        completion(nil, .invalidData)
                        return
                    }
                    completion(imageData, nil)
                }
            }
        }
    }
}
