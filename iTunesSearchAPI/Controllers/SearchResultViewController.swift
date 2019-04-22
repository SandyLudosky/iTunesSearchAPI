//
//  ViewController.swift
//  iTunesSearchAPI
//
//  Created by Sandy Ludosky on 20/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import UIKit

class SearchResultViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeader: UIView!
    
    let viewModel = SearchResultViewModel()
    let searchController = UISearchController(searchResultsController: nil)
    var data: [Result] = []
    var searchActive : Bool = false
    var action: Action?
    
    lazy var dataSource: SearchResultDataSource? = {
         guard let results = self.viewModel.data else { return nil }
        return SearchResultDataSource(items: results)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        loadData()
    }
    
    private func loadData() {
        viewModel.search(term: "eminem", country: .us, type: .music, entity: .music(.song)) { error in
            if error == nil {
                self.collectionView.dataSource = self.dataSource
                self.collectionView.reloadData()
            } else {
                print("error = \(String(describing: error?.description))")
            }
        }
    }
    
    private func configureView() {
        let nib = UINib(nibName: "SearchCollectionViewCell", bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
        configureSearchBar()
    }
}

//MARK: UISearchBarDelegate & UISearchResultsUpdating & UISearchControllerDelegate
extension SearchResultViewController: UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {
    var isSeachBarEmpty: Bool {
        return searchController.searchBar.text == ""
    }
    
    var seachBarText: String? {
        guard let text = searchController.searchBar.text else { return nil }
        return text
    }
    
    private func configureSearchBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(SearchResultViewController.dismissSearchResultsController))
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = action == .search ? "Search ..." : "LookUp with IDs"
        searchController.searchBar.becomeFirstResponder()
        searchController.searchBar.barTintColor = .lightGray
        searchController.searchBar.setBackgroundImage(UIImage(), for: .top, barMetrics: .default)
        definesPresentationContext = true
        collectionViewHeader.backgroundColor = .lightGray
        collectionViewHeader.addSubview(self.searchController.searchBar)
  
    }
    
    private func updateSearchResults() {
        
        //action is either search with text or lookup with ID
        if !isSeachBarEmpty {
            if action == .search {
                viewModel.search(term: seachBarText ?? "", country: .us, type: .music, entity: .music(.song)) { error in
                    if error == nil {
                        guard let results = self.viewModel.data else { return }
                        self.dataSource?.update(with: results)
                        self.collectionView.reloadData()
                    } else {
                         print("error = \(String(describing: error?.description))")
                    }
                }
            } else {
                viewModel.lookup(with: seachBarText ?? "", entity: nil) { error in
                    if error == nil {
                        guard let results = self.viewModel.data else { return }
                        self.dataSource?.update(with: results)
                        self.collectionView.reloadData()
                    } else {
                        print("error = \(String(describing: error?.description))")
                    }
                }
            }
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text!)
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
