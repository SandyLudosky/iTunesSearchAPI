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
    let dataManager = DataManagerService()
    
    func loadArtwork(with service: APIService, _ completion: @escaping ImageDataHandler) {
        dataManager.get(for: service) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    guard let dataValid = data as? Data else { return }
                    completion(dataValid, nil)
                }
            case .failure(let error):
                 completion(nil, error)
            }
        }
    }
    
    func loadPreview(with url: String, _ completion: @escaping PreviewURLHandler) {
        guard let preview = URL(string: url) else {
            completion(nil, .invalidData)
            return
        }
        completion(preview, nil)
    }
}
