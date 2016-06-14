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
    
    var dataSource = [Tweet](){
        didSet{
            self.tableView.reloadData()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        JSONParser.tweetJSONFrom(JSONParser.JSONData()) { (success, tweets) in
//            if success{
//                for tweet in tweets!{
//                    print(tweet.text)
//                }
//            }
//        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.update()
        
//        JSONParser.tweetJSONFrom(JSONParser.JSONData()) { (success, tweets) in
//            if let tweets = tweets{
//                self.dataSource = tweets
//            }
//        }
    }
    
    func update(){
        API.shared.getTweets { (tweets) in
            if let tweets = tweets{
                self.dataSource = tweets
            }
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
