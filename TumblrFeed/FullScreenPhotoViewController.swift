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
                self.postImageWidth = post.image.imageWidth
                self.postImageHeight = post.image.imageHeight
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
    
    var postImageWidth: CGFloat = 0
    var postImageHeight: CGFloat = 0
    
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        return sv
    }()
    
    lazy var imageView: UIImageView = {
        let iv = UIImageView(frame: CGRect(x: 0, y: 0, width: self.postImageWidth, height: self.postImageHeight))
        iv.backgroundColor = .red
        return iv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.backgroundColor = UIColor.black
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let centerY: CGFloat = (self.postImageHeight - self.scrollView.frame.height ) / 2
        let centerX: CGFloat = (self.postImageWidth - self.scrollView.frame.width) / 2
        scrollView.contentOffset = CGPoint(x: centerX, y: centerY)
        scrollView.contentSize = imageView.bounds.size
        scrollView.delegate = self
        scrollView.addSubview(imageView)
        view.addSubview(scrollView)
        setZoomScale()
        setupGestureRecognizer()
        
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

    func setZoomScale() {
        let imageViewSize = imageView.bounds.size
        let scrollViewSize = scrollView.bounds.size
        let widthScale = scrollViewSize.width / imageViewSize.width
        let heightScale = scrollViewSize.height / imageViewSize.height
        
        scrollView.minimumZoomScale = min(widthScale, heightScale)
        scrollView.zoomScale = 1.0
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {

        let imageViewSize = imageView.frame.size
        let scrollViewSize = scrollView.bounds.size
        
        let verticalPadding = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.height) / 2 : 0
        let horizontalPadding = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2 : 0
        
        scrollView.contentInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
    }

    override func viewWillLayoutSubviews() {
        setZoomScale()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissView(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
    func setupGestureRecognizer() {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTap.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTap)
    }
    
    func handleDoubleTap(_ recognizer: UITapGestureRecognizer) {
        
        if (scrollView.zoomScale > scrollView.minimumZoomScale) {
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        } else {
            scrollView.setZoomScale(scrollView.maximumZoomScale, animated: true)
        }
    }

}








