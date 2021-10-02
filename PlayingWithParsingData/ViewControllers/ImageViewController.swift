//
//  ImageViewController.swift
//  PlayingWithParsingData
//
//  Created by Dmitry Logachev on 24.09.2021.
//

import UIKit

class ImageViewController: UIViewController {
   
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        fetchImage()
    }
    
    private func fetchImage() {
        NetworkManager.shared.fetchImage(from: Link.imageUrl.rawValue) { result in
            switch result {
            case .success(let data):
                self.imageView.image = UIImage(data: data)
                self.activityIndicator.stopAnimating()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
