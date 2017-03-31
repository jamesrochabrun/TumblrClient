//
//  Extensions.swift
//  TumblrFeed
//
//  Created by James Rochabrun on 3/31/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func cleanHTML() -> String {
        return  self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}

extension Double {
    
    func formatTimeStamp() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        let date = Date(timeIntervalSince1970: self)
        dateFormatter.locale = Locale(identifier: "en_US")
        let str = dateFormatter.string(from: date)
        return str
    }
}
