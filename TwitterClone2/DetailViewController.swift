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
    @IBOutlet weak var profileImageView: UIImageView!
    
    var tweet = Tweet?()
    
    var cache: Cache<UIImage>?{
        if let delegate = UIApplication.sharedApplication().delegate as? AppDelegate{
            return delegate.cache
        }
        return nil
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup(){
        if let tweet = self.tweet, user = tweet.user{
            if let originalTweet = tweet.retweet, originalUser = originalTweet.user{
                self.navigationItem.title = "Retweet"
                self.tweetLabel.text = originalTweet.text
                self.userNameLabel.text = originalUser.name
                
                self.profileImage(originalUser.profileImageURL, completion: { (image) in
                    self.profileImageView.image = image
                })
            }else{
                self.navigationItem.title = "Tweet"
                self.tweetLabel.text = tweet.text
                self.userNameLabel.text = user.name
                
                self.profileImage(user.profileImageURL, completion: { (image) in
                    self.profileImageView.image = image
                })
            }
        }
    }
    
    func profileImage(key: String, completion:(image:UIImage) ->()){
        if let image = cache?.read(key){
            completion(image: image)
            return
        }
        
        API.shared.getImages(key) {(image) in
            self.cache?.write(image, key: key)
            completion(image: image)
            return
    }
}
}
