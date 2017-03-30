//
//  Blog.swift
//  TumblrFeed
//
//  Created by James Rochabrun on 3/30/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import Foundation
import UIKit

struct Blog {
    
    let avatarURL: String = "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/avatar"
    let title: String
    let posts: [Post?]
}

extension Blog {
    
    
    struct  Key {
        static let blog: String = "blog"
        static let blogTitle: String = "title"
        static let postsArray: String = "posts"
    }
    
    init?(json: [String: AnyObject]) {
        
        guard let blog = json[Key.blog] as? [String: AnyObject],
            let blogTitle = blog[Key.blogTitle] as? String,
            let postsArary = json[Key.postsArray] as? [[String: AnyObject]] else {
                return nil
        }
        
        self.title = blogTitle
        self.posts = postsArary.map{Post.init(json: $0)}
    }
}
