//
//   Configure the view for the selected state     }  } SearchResultTableViewCell.swift
//  iTunesSearchAPI
//
//  Created by Sandy Ludosky on 25/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
    @IBOutlet var img: UIImageView!
    @IBOutlet var artistName: UILabel!
    @IBOutlet var trackName: UILabel!
    static let identifier = "searchIdentifier"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension SearchResultTableViewCell {
    public func configure(with model: SearchCellViewModel) {
        trackName.text = model.name
        artistName.text = model.artist
        if let url = model.artwork {
            model.preview(with: url) { image in
                DispatchQueue.main.async {
                    self.img.image = image
                }
            }
        }
        if model.previewURL == nil {
            self.alpha = 0.5
            self.isUserInteractionEnabled = false
        }
    }
}
