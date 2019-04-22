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
    let dataController = DataController()
    
    var result: Result?
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView() {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
