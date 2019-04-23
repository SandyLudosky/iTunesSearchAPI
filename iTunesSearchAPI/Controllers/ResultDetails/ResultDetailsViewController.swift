//
//  ResultDetailsViewController.swift
//  iTunesSearchAPI
//
//  Created by Sandy Ludosky on 22/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import UIKit
import WebKit

class ResultDetailsViewController: BaseViewController {
    
    @IBOutlet weak var resultImageView: UIImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var resultWebView: WKWebView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    let viewModel = ResultDetailsViewModel()
    var result: Result?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureView()
    }
}

extension ResultDetailsViewController {
    func configureView() {
        resultWebView.uiDelegate = self
        resultWebView.navigationDelegate = self
        if let r = result {
            viewModel.displayDetails(with: r) {
                if let req = viewModel.request {
                    resultWebView.load(req)
                }
                viewModel.loadArtwork(completion: { img in
                    self.resultImageView.image = img
                })
                
                artistNameLabel.text = result?.artistName
                trackNameLabel.text = result?.trackName
            }
        }
    }
}

extension ResultDetailsViewController: WKNavigationDelegate, WKUIDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loader.stopAnimating()
        loader.isHidden = false
    }
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        loader.startAnimating()
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        loader.stopAnimating()
    }
}
