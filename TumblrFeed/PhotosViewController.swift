//
//  ViewController.swift
//  TumblrFeed
//
//  Created by James Rochabrun on 3/30/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import UIKit
import Alamofire

class PhotosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    lazy var refreshControl: UIRefreshControl = {
        let rf = UIRefreshControl()
        rf.addTarget(self, action: #selector(refresh(_:)), for: UIControlEvents.valueChanged)
        return rf
    }()
    
    @IBOutlet weak var tableView: UITableView!
    private var blog: Blog? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
                self?.refreshControl.endRefreshing()
            }
        }
    }
    private let cellID = "cellID"
    private let headerCellID = "headerID"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.insertSubview(refreshControl, at: 0)
        tableView.register(HederView.self, forCellReuseIdentifier: headerCellID)
        getData()
    }
    
    func getData() {
        let blogService = BlogService()
        blogService.get { (result) in
            switch result {
            case .Success(let blog):
                self.blog = blog
            case .Error(let error):
                print(error)
            }
        }
    }
    
    func refresh(_ refreshControl: UIRefreshControl) {
        getData()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? PhotoCell else {
            fatalError("Cell can't be dequed")
        }
        if let post = blog?.posts[indexPath.section] {
            cell.setUpCell(with: post)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let count = blog?.posts.count {
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = tableView.dequeueReusableCell(withIdentifier: headerCellID) as? HederView
        if let post = blog?.posts[section] {
            header?.post = post
        }
        if let blog = self.blog {
            header?.blog = blog
        }
        return header
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detailSegue" {
            if let vc = segue.destination as? PhotoDetailsViewController,
                let indexPath = tableView.indexPath(for: sender as! PhotoCell) {
                let post = blog?.posts[indexPath.section]
                vc.post = post
            }
        }
    }
    
    
}






































