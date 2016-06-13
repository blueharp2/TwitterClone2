//
//  ViewController.swift
//  TwitterClone2
//
//  Created by Lindsey on 6/13/16.
//  Copyright © 2016 Lindsey Boggio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    var dataSource = [Tweet](){
        didSet{
            //Reload Data
            //if let Tweets
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        JSONParser.tweetJSONFrom(JSONParser.JSONData()) { (success, tweets) in
            if success{
                for tweet in tweets!{
                    print(tweet.text)
                }
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
