//
//  ResultDetailsViewModel.swift
//  iTunesSearchAPI
//
//  Created by Sandy Ludosky on 30/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import Foundation
import UIKit

public struct ResultDetailsViewModel {
    let trackName: String
    let artistName: String
    let request: URLRequest?
    let artwork: UIImage?
}
