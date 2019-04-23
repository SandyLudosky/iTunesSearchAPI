//
//  ResultDetailsViewController.swift
//  iTunesSearchAPI
//
//  Created by Sandy Ludosky on 22/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import UIKit
import WebKit

class ResultDetailsViewController: UIViewController {
    
    @IBOutlet weak var resultImageView: UIImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var resultWebView: WKWebView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    let dataController = DataController()
    
    var result: Result?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureView()
    }
    
    func configureView() {
        resultWebView.uiDelegate = self
        resultWebView.navigationDelegate = self
      
        if let artwork = result?.artworkUrl60 {
            preview(with: artwork) { image in
                DispatchQueue.main.async {
                    self.resultImageView.image = image
                }
            }
        }
        
        artistNameLabel.text = result?.artistName
        trackNameLabel.text = result?.trackName
        if let preview = result?.previewURL {
            guard let url = URL(string: preview) else { return }
            let request = URLRequest(url: url)
            resultWebView.load(request)
        }
    }
}

extension ResultDetailsViewController {
    func preview(with url: String, completion: @escaping (UIImage) -> Void) {
        dataController.download(with: url) { (data, error) in
            if error == nil {
                guard let imageData = data else { return }
                guard let img = (UIImage(data: imageData)) else { return }
                completion(img)
            }
        }
    }   
}

extension ResultDetailsViewController: WKNavigationDelegate, WKUIDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finish")
        loader.stopAnimating()
        loader.isHidden = false
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
         loader.startAnimating()
         print("did commit")
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        loader.stopAnimating()
        print("did fail")
        AlertDialogView.build(with: "error loading preview", vc: self)
    }
}
