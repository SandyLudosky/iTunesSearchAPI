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
    @IBOutlet weak var webView: UIView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    var viewModel = ResultDetailsViewModel()
    var vm: ResultViewModel?
    var result: Result?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = vm?.trackName
        //configureView()
    }
}

extension ResultDetailsViewController {
    func configureView() {
        if let r = result {
            viewModel.displayDetails(with: r) {
                if #available(iOS 9.1, *) {
                    if let req = viewModel.request {
                        let webConfiguration = WKWebViewConfiguration()
                        let resultWebView = WKWebView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 300), configuration: webConfiguration)
                        resultWebView.uiDelegate = self
                        resultWebView.navigationDelegate = self
                        webView.addSubview(resultWebView)
                        resultWebView.load(req)
                    }
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
