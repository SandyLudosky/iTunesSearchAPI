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
    let searchController = UISearchController(searchResultsController: nil)
    var data: [Result] = []
    var searchActive : Bool = false
    var action: Action?
    var presenter: SearchResultsPresenterProtocol?
    
    var dataSource = SearchResultDataSource(items: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setup()
        loadData()
    }
    private func loadData() {
        self.tableView.dataSource = dataSource
        self.tableView.delegate = self
        presenter?.showResults(for: .search(term: "eminem", media: .music(entity: .song, attribute: nil), country: .unitedStates), { (resultsViewModel, err) in
            if err == nil {
                guard let results =  resultsViewModel else { return  }
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

extension SearchResultsViewController: SearchResultsViewProtocol {
    func setup() {
        let viewController = self
        let presenter = SearchResultsPresenter()
        let interactor = SearchResultsInteractor()
        let router = SearchResultsRouter()
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        router.viewController = self
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
        
                presenter?.showResults(for: .search(term: seachBarText ?? "", media: .music(entity: .song, attribute: nil), country: .unitedStates), { (viewModels, error) in
                    if error == nil {
                        guard let results = viewModels else {
                            return
                        }
                        self.dataSource.update(with: results)
                        self.tableView.reloadData()
                    } else {
                        AlertDialogView.build(with: String(describing: error?.errorDescription), vc: self)
                    }
                })
            case .lookUp: break
                /*
                     viewModel.lookup(with: seachBarText ?? "", entity: nil) { err in
                     if err == nil {
                     guard let results = self.viewModel.data else {
                     return
                     }
                     // self.dataSource.update(with: results)
                     self.tableView.reloadData()
                     } else {
                     AlertDialogView.build(with: String(describing: err?.errorDescription), vc: self)
                     }
                     }
                 */
                
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
        let result = dataSource.results[indexPath.row]
    let model = ResultViewModel(trackName: result.trackName, artistName: result.artistName, previewURL: result.previewURL , artwork: result.artwork )
        if result.previewURL != "" {
            presenter?.showResultDetail(for: model)
        }
    }
}

