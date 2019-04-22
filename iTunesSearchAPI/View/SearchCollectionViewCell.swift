//
//  SearchCollectionViewCell.swift
//  iTunesSearchAPI
//
//  Created by Sandy Ludosky on 21/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    @IBOutlet var image: UIImageView!
    @IBOutlet var artistName: UILabel!
    @IBOutlet var trackName: UILabel!
    static let identifier = "searchIdentifier"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(with model: SearchCollectionViewModel) {
        trackName.text = model.name
        if let url = model.artwork {
            model.preview(with: url) { image in
                DispatchQueue.main.async {
                  self.image.image = image
                } 
            }
        }
        if model.previewURL == nil {
            self.alpha = 0.5
            self.isUserInteractionEnabled = false
        }
    }
    
    public func didSelect(for model: SearchCollectionViewModel) {
        if let preview = model.previewURL {
            
        }
    }
}
