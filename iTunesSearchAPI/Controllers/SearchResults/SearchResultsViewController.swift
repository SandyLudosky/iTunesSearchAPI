//
//  ViewController.swift
//  iTunesSearchAPI
//
//  Created by Sandy Ludosky on 20/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import UIKit

class SearchResultsViewController: BaseViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeader: UIView!
    
    let viewModel = SearchResultsViewModel()
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
        viewModel.search(term: "eminem", mediaType: .music(entity: .song, attribute: nil), country: .us, completion: { err in
            if err == nil {
                self.collectionView.dataSource = self.dataSource
                self.collectionView.reloadData()
            } else {
                AlertDialogView.build(with: String(describing: err?.errorDescription), vc: self)
            }
        })
    }
    private func configureView() {
        let nib = UINib(nibName: "SearchCollectionViewCell", bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
        collectionView.delegate = self
        configureSearchBar()
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
    private func configureSearchBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(SearchResultsViewController.dismissSearchResultsController))
        self.navigationItem.rightBarButtonItem?.tintColor = Color.info
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        if #available(iOS 9.1, *) {
            searchController.obscuresBackgroundDuringPresentation = false
        } else {
            // Fallback on earlier versions
            searchController.dimsBackgroundDuringPresentation = false
        }
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
                //search example search(term: "eminem", mediaType: .music(entity: .mix, attribute: .mixTerm)
                viewModel.search(term: "eminem", mediaType: .music(entity: .song, attribute: nil), country: .us, completion: { err in
                    if err == nil {
                        self.collectionView.dataSource = self.dataSource
                        self.collectionView.reloadData()
                    } else {
                        AlertDialogView.build(with: String(describing: err?.errorDescription), vc: self)
                    }
                })
            } else {
                viewModel.lookup(with: seachBarText ?? "", entity: nil) { err in
                    if err == nil {
                        guard let results = self.viewModel.data else {
                            return
                        }
                        self.dataSource?.update(with: results)
                        self.collectionView.reloadData()
                    } else {
                        print("error = \(String(describing: err?.errorDescription))")
                    }
                }
            }
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text!)
        self.viewModel.data = nil
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

extension SearchResultsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("track selected \(String(describing: viewModel.data?[indexPath.row]))")
        guard let currentCell = collectionView.cellForItem(at: indexPath) as? SearchCollectionViewCell else { return }
        let result = viewModel.data?[indexPath.row]
        if let _ = result?.previewURL {
            performSegue(withIdentifier: "goToDetails", sender: currentCell)
        }
    }
}

// MARK: - Navigation
extension SearchResultsViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetails" {
            
            guard let cell = sender as? SearchCollectionViewCell else {
                assertionFailure("Failed to unwrap sender. Try to set a breakpoint here and check what sender is")
                return
            }
            guard let resultDetailsVC = segue.destination as? ResultDetailsViewController else {
                assertionFailure("Failed to unwrap sender. Try to set a breakpoint here and check what sender is")
                return
            }
            guard let indexPath = collectionView.indexPath(for: cell) else {
                return
            }
            resultDetailsVC.result = dataSource?.result(at: indexPath)
        }
    }
}
