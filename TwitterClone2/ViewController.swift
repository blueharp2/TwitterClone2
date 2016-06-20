//
//  ViewController.swift
//  TwitterClone2
//
//  Created by Lindsey on 6/13/16.
//  Copyright © 2016 Lindsey Boggio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var cache: Cache<UIImage>?{
        if let delegate = UIApplication.sharedApplication().delegate as? AppDelegate{
            return delegate.cache
        }
        return nil
    }
    
    var dataSource = [Tweet](){
        didSet{
            self.tableView.reloadData()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.navigationItem.title = "Tweets"
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.update()
        
    }
    
    func update(){
        API.shared.getTweets { (tweets) in
            if let tweets = tweets{
                self.dataSource = tweets
            }
        }
    }
    
    func setupTableView(){
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == DetailViewController.id(){
            guard let detailViewController = segue.destinationViewController as? DetailViewController else{return}
            guard let indexPath = self.tableView.indexPathForSelectedRow else {return}
            
            detailViewController.tweet = self.dataSource[indexPath.row]
            
        }
    }
}




extension ViewController:UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tweetCell", forIndexPath: indexPath)
        let tweet = self.dataSource[indexPath.row]
        
        cell.textLabel?.text = tweet.text
        
        return cell
    }
}
