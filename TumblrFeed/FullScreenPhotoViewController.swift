//
//  FullScreenPhotoViewController.swift
//  TumblrFeed
//
//  Created by James Rochabrun on 3/30/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import UIKit

class FullScreenPhotoViewController: UIViewController, UIScrollViewDelegate {
    
    var post: Post? {
        didSet {
            
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let post = post {
//            scrollView.contentSize = CGSize(width: post.image.imageWidth, height: post.image.imageHeight)
        }


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissView(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }

}








