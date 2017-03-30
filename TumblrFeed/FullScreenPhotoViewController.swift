//
//  FullScreenPhotoViewController.swift
//  TumblrFeed
//
//  Created by James Rochabrun on 3/30/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import UIKit
import Alamofire

class FullScreenPhotoViewController: UIViewController, UIScrollViewDelegate {
    
    var post: Post? {
        didSet {
            if let post = post {
                Alamofire.request(post.image.imageOriginalURL).response { [weak self] response in
                    if let data = response.data {
                        DispatchQueue.main.async {
                            self?.imageView.image = UIImage(data: data)
                        }
                    }
                }
            }
        }
    }
    
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let post = post {
            
            view.addSubview(scrollView)
        
            scrollView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            
            scrollView.contentSize = imageView.bounds.size
            scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            scrollView.indicatorStyle = .white
            scrollView.minimumZoomScale = 0.3
            scrollView.maximumZoomScale = 3.0
            scrollView.delegate = self;
            scrollView.addSubview(imageView)
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissView(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }

}








