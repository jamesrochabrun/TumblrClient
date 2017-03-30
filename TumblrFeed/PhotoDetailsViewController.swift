//
//  PhotoDetailsViewController.swift
//  TumblrFeed
//
//  Created by James Rochabrun on 3/30/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class PhotoDetailsViewController: UIViewController {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var photoImageview: UIImageView!
    private let zoomSegue = "zoomSegue"
    var post: Post? {
        didSet {
            if let post = post {
                Alamofire.request(post.image.imageOriginalURL).response { [weak self] response in
                    if let data = response.data {
                        DispatchQueue.main.async {
                            self?.photoImageview.image = UIImage(data: data)
                        }
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoImageView.isUserInteractionEnabled = true
        photoImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    func  handleTap() {
        performSegue(withIdentifier: zoomSegue, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == zoomSegue {
            if let nc = segue.destination as? UINavigationController,
                let vc = nc.topViewController as? FullScreenPhotoViewController {
                vc.post = post
            }
        }
    }
}








