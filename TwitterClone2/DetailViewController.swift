//
//  DetailViewController.swift
//  TwitterClone2
//
//  Created by Lindsey on 6/15/16.
//  Copyright © 2016 Lindsey Boggio. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController,Identity {

    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    
    var tweet = Tweet?()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tweet = self.tweet{
            self.tweetLabel.text = tweet.text
            self.userNameLabel.text = tweet.user?.name
        }

        
    }

}
