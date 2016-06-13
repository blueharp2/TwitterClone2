//
//  ViewController.swift
//  TwitterClone2
//
//  Created by Lindsey on 6/13/16.
//  Copyright © 2016 Lindsey Boggio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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

