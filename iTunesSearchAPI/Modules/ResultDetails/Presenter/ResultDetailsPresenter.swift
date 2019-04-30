//
//  ResultDetailsPresenter.swift
//  iTunesSearchAPI
//
//  Created by Sandy Ludosky on 30/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import Foundation
import UIKit
class ResultDetailsPresenter: ResultDetailsPresenterProtocol  {
    var interactor: ResultDetailsInteractorProtocol?
    var viewModelDetails: ResultDetailsViewModel?
 
    func showResultDetail(for viewModel: ResultViewModel, completion: @escaping () -> ()) {
        viewModelDetails = ResultDetailsViewModel()
        interactor?.loadArtwork(with: .download(url: viewModel.artwork), { (data, error) in
            if error == nil {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    self.viewModelDetails?.artwork = UIImage(data: data)
                    completion()
                }
            }
        })

        interactor?.loadPreview(with: viewModel.previewURL, { (url, error) in
            guard let url = url else { return }
            DispatchQueue.main.async {
              self.viewModelDetails?.request = URLRequest(url: url)
            }
        })
    }
}
