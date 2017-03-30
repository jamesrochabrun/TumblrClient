//
//  BlogService.swift
//  TumblrFeed
//
//  Created by James Rochabrun on 3/30/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import Foundation

struct BlogService {
    
    let endpoint: String = "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV"
    
    let downloader = JSONDownloader()
    typealias PostsCompletionHandler = (Result<Blog?>) -> ()
    
    func get(completion: @escaping PostsCompletionHandler) {
        
        guard let url = URL(string: self.endpoint) else {
            completion(.Error(.invalidURL))
            return
        }
        let request = URLRequest(url: url)
        let task = downloader.jsonTask(with: request) { (result) in
            
            DispatchQueue.main.async {
                switch result {
                case .Error(let error):
                    completion(.Error(error))
                    return
                case .Success(let json):
                    guard let postsJSONFeed = json["response"] as? [String: AnyObject] else {
                        completion(.Error(.jsonParsingFailure))
                        return
                    }
                    
                    let blog = Blog.init(json: postsJSONFeed)
                    completion(.Success(blog))
                }
            }
        }
        task.resume()
    }
}
