//
//  PhotoCell.swift
//  TumblrFeed
//
//  Created by James Rochabrun on 3/30/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import Foundation
import UIKit

import Alamofire

class PhotoCell: UITableViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    func setUpCell(with post: Post) {
        Alamofire.request(post.image.imageOriginalURL).response { [weak self] response in
            if let data = response.data {
                DispatchQueue.main.async {
                self?.photoImageView.image = UIImage(data: data)
                }
            }
        }
    }
    
    
}
