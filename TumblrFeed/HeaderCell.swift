//
//  HeaderCell.swift
//  TumblrFeed
//
//  Created by James Rochabrun on 3/30/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class HederView: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var blog: Blog? {
        didSet {
            if let blog = blog {
                Alamofire.request(blog.avatarURL).response { [weak self] response in
                    if let data = response.data {
                        DispatchQueue.main.async {
                            self?.avatarImageView.image = UIImage(data: data)
                        }
                    }
                }
            }
        }
    }
    
    var post: Post? {
        didSet {
            if let post = post {
                self.dateLabel.text = post.date
            }
        }
    }
    
    let avatarImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 20
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let dateLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    func setUpViews() {
        backgroundColor = UIColor(white: 1, alpha: 0.9)
        addSubview(avatarImageView)
        avatarImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        avatarImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        avatarImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        addSubview(dateLabel)
        dateLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        dateLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
