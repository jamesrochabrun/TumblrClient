//
//  Post.swift
//  TumblrFeed
//
//  Created by James Rochabrun on 3/30/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import Foundation
import UIKit

struct Post {
    
    let date: Double
    let summary: String
    let caption: String
    let image: PostImage
}

extension Post {
    
    struct Key {
        static let timestamp: String = "timestamp"
        static let summmaryString: String = "summary"
        static let captionString: String = "caption"
        static let photosArray: String = "photos"
        static let originalSize: String = "original_size"
        static let imageURL: String = "url"
        static let imageWidth: String = "width"
        static let imageHeight: String = "height"
    }
    
    init?(json: [String: AnyObject]) {
        
        guard let dateString = json[Key.timestamp] as? Double,
            let summaryString = json[Key.summmaryString] as? String,
            let captionString = json[Key.captionString] as? String,
            let photosArray = json[Key.photosArray] as? [[String: AnyObject]],
            let photoData = photosArray.first,
            let originalSizeImageDict = photoData[Key.originalSize] as? [String: AnyObject],
            let imageURL = originalSizeImageDict[Key.imageURL] as? String,
            let imageWidth = originalSizeImageDict[Key.imageWidth] as?CGFloat,
            let imageHeight = originalSizeImageDict[Key.imageHeight] as? CGFloat
            
            else {
                return nil
        }
        
        self.date = dateString
        self.summary = summaryString
        self.caption = captionString
        self.image = PostImage(imageOriginalURL: imageURL, imageWidth: imageWidth, imageHeight: imageHeight)
    }
}

struct PostImage {
    
    let imageOriginalURL: String
    let imageWidth: CGFloat
    let imageHeight: CGFloat
}
