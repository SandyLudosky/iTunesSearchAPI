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
    @IBOutlet weak var loader: UIActivityIndicatorView!
    var viewModel: ResultDetailsViewModel?
    var vm: ResultViewModel?
    var result: Result?
    var presenter: ResultDetailsPresenterProtocol?
    var resultWebView: WKWebView?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUp()
        configureView()
        showResultDetails()
    }
}

extension ResultDetailsViewController: ResultDetailsViewProtocol {
    func setUp() {
        let viewController = self
        let presenter = ResultDetailsPresenter()
        let interactor = ResultDetailsInteractor()
        viewController.presenter = presenter
        presenter.interactor = interactor
    }
    
    func configureView() {
        self.title = vm?.trackName
    }
    
    func showResultDetails() {
        guard let vm = vm else { return }
        presenter?.showResultDetail(for: vm, completion: {
            if let request = self.presenter?.viewModelDetails?.request {
                self.loadWebView(with: request)
                self.loader.startAnimating()
            }
            if let artwork = self.presenter?.viewModelDetails?.artwork {
                self.loadImage(with: artwork)
            }
        })
    }
}

//MARK - Private
extension ResultDetailsViewController {
    private func loadWebView(with request: URLRequest) {
        if #available(iOS 9.1, *) {
            let webConfiguration = WKWebViewConfiguration()
            resultWebView = WKWebView(frame: CGRect(x: 0, y:(self.view.frame.height/2) - 150, width: self.view.frame.width, height: 300), configuration: webConfiguration)
            resultWebView?.backgroundColor = Color.darkGray
            resultWebView?.uiDelegate = self
            resultWebView?.navigationDelegate = self
            resultWebView?.load(request)
        }
    }
    
    private func loadImage(with artwork: UIImage) {
       // resultImageView.image = artwork
    }
}

extension ResultDetailsViewController: WKNavigationDelegate, UIWebViewDelegate, WKUIDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loader.stopAnimating()
        loader.isHidden = false
    }
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        if let webView = resultWebView {
              self.view.addSubview(webView)
        }
      
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        loader.stopAnimating()
    }
}
