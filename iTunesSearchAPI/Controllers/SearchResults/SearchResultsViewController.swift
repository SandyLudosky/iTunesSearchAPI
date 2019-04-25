//
//  ViewController.swift
//  iTunesSearchAPI
//
//  Created by Sandy Ludosky on 20/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import UIKit

class SearchResultsViewController: BaseViewController {
    @IBOutlet var tableView: UITableView!
    let viewModel = SearchResultsViewModel()
    let searchController = UISearchController(searchResultsController: nil)
    var data: [Result] = []
    var searchActive : Bool = false
    var action: Action?
    
    var dataSource = SearchResultDataSource(items: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        loadData()
    }
    private func loadData() {
      
        self.tableView.dataSource = dataSource
        viewModel.search(term: "eminem", mediaType: .music(entity: .song, attribute: nil), country: .unitedStates, completion: { err in
            if err == nil {
                guard let results = self.viewModel.data else { return  }
                self.dataSource.update(with: results)
                self.tableView.reloadData()
            } else {
                AlertDialogView.build(with: String(describing: err?.errorDescription), vc: self)
            }
        })
    }
    private func configureView() {
        tableView.register(UINib(nibName: "SearchResultTableViewCell", bundle: nil), forCellReuseIdentifier: SearchResultTableViewCell.identifier)
        configureSearchBarForTableView()
        tableView.delegate = self
    }
}

//MARK: UISearchBarDelegate & UISearchResultsUpdating & UISearchControllerDelegate
extension SearchResultsViewController: UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {
    var isSeachBarEmpty: Bool {
        return searchController.searchBar.text == ""
    }
    var seachBarText: String? {
        guard let text = searchController.searchBar.text else { return nil }
        return text
    }
    
    private func configureSearchBarForTableView() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(SearchResultsViewController.dismissSearchResultsController))
        
        tableView.tableHeaderView = searchController.searchBar
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = action == .search ? "Search ..." : "LookUp with IDs"
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.delegate = self
        
        if #available(iOS 9.1, *) {
            searchController.obscuresBackgroundDuringPresentation = false
        } else {
            // Fallback on earlier versions
            searchController.dimsBackgroundDuringPresentation = false
        }
        definesPresentationContext = true
    }
    
    private func updateSearchResults() {
        guard let option = action else { return }
        if !isSeachBarEmpty {
            switch option {
            //search example search(term: "eminem", mediaType: .music(entity: .mix, attribute: .mixTerm)
            case .search:
                viewModel.search(term: seachBarText ?? "", mediaType: .music(entity: .song, attribute: nil), country: .unitedStates, completion: { err in
                    if err == nil {
                        guard let results = self.viewModel.data else {
                            return
                        }
                        self.dataSource.update(with: results)
                        self.tableView.reloadData()
                    } else {
                        AlertDialogView.build(with: String(describing: err?.errorDescription), vc: self)
                    }
                })
            case .lookUp:
                viewModel.lookup(with: seachBarText ?? "", entity: nil) { err in
                    if err == nil {
                        guard let results = self.viewModel.data else {
                            return
                        }
                        self.dataSource.update(with: results)
                        self.tableView.reloadData()
                    } else {
                        AlertDialogView.build(with: String(describing: err?.errorDescription), vc: self)
                    }
                }
            }
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        updateSearchResults()
    }
    @objc func dismissSearchResultsController(_ sender: UIBarButtonItem) {
        searchActive = false
        self.dismiss(animated: true, completion: nil)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}

extension SearchResultsViewController: UITableViewDelegate {
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let currentCell = tableView.cellForRow(at: indexPath) as? SearchResultTableViewCell else { return }
        let result = viewModel.data?[indexPath.row]
        if let _ = result?.previewURL {
            performSegue(withIdentifier: "goToDetails", sender: currentCell) // segue only if preview is available
        }
    }
}

// MARK: - Navigation
extension SearchResultsViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetails" {
            guard
            let cell = sender as? SearchResultTableViewCell,
            let resultDetailsVC = segue.destination as? ResultDetailsViewController
                else {
                assertionFailure("Failed to unwrap sender. Try to set a breakpoint here and check what sender is")
                return
            }
            guard let indexPath = tableView.indexPath(for: cell) else {
                return
            }
            resultDetailsVC.result = dataSource.result(at: indexPath)
        }
    }
}
