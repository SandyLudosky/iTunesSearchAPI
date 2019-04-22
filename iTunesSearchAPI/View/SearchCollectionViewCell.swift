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
    @IBOutlet var name: UILabel!
    static let identifier = "searchIdentifier"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
    }
    
    public func configure(with model: SearchCollectionViewModel) {
        name.text = model.name
        if let url = model.artwork {
            model.preview(with: url) { image in
                DispatchQueue.main.async {
                  self.image.image = image
                }
            }
        }
    }
}
