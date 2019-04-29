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
    var results: [ResultViewModel]
    init(items: [ResultViewModel]) {
        self.results = items
        super.init()
    }
    // MARK: - Helper
    func update(with data: [ResultViewModel]) {
        results = data
    }
    func result(at indexPath: IndexPath) -> ResultViewModel {
        return results[indexPath.row]
    }
}

// MARK: - UITableDataSource
extension SearchResultDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.identifier, for: indexPath) as? SearchResultTableViewCell else {
            return UITableViewCell()
        }
        let result = results[indexPath.row]
        let viewModel = SearchCellViewModel(with: result)
        cell.configure(with: viewModel)
        return cell
    }
}
