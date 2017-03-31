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
    
    private let zoomSegue = "zoomSegue"
    @IBOutlet weak var photoImageview: UIImageView!
    @IBOutlet weak var thumbnailImageview: UIImageView!
    @IBOutlet weak var captionText: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    var post: Post? {
        didSet {
            if let post = post {
                Alamofire.request(post.image.imageOriginalURL).response { [weak self] response in
                    if let data = response.data {
                        DispatchQueue.main.async {
                            self?.photoImageview.image = UIImage(data: data)
                            self?.thumbnailImageview.image = UIImage(data: data)
                            self?.captionText.text = post.caption.cleanHTML()
                            self?.dateLabel.text = post.date.formatTimeStamp()
                        }
                    }
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        captionText.contentInset = UIEdgeInsets(top: -40, left: 0, bottom: 0, right: 0)
        thumbnailImageview.layer.cornerRadius = 40.0
        thumbnailImageview.isUserInteractionEnabled = true
        thumbnailImageview.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        photoImageview.blur(with: .light)
        photoImageview.opaque(with: 0.1)

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







