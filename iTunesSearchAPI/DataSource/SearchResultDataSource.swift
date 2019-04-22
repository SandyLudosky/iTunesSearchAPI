//
//  DataSource.swift
//  iTunesSearchAPI
//
//  Created by Sandy Ludosky on 21/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import Foundation
import UIKit

class SearchResultDataSource: NSObject {
    
    private var results: [Result]
  
    init(items: [Result]) {
        self.results = items
        super.init()
        
    }
    // MARK: - Helper
    func update(with data: [Result]) {
       results = data
    }
    
    func result(at indexPath: IndexPath) -> Result {
        return results[indexPath.row]
    }
}

 // MARK: - UICollectionViewDataSource
extension SearchResultDataSource: UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as? SearchCollectionViewCell else {
            return UICollectionViewCell()
        }
        let result = results[indexPath.row]
        let viewModel = SearchCollectionViewModel(with: result)
        cell.configure(with: viewModel)
        return cell
    }
}
