//
//  TweetCell.swift
//  TwitterClone2
//
//  Created by Lindsey on 6/20/16.
//  Copyright © 2016 Lindsey Boggio. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    
    var cache: Cache<UIImage>?{
        if let delegate = UIApplication.sharedApplication().delegate as? AppDelegate{
            return delegate.cache
        }
        return nil
    }
    
    var tweet: Tweet!{
        didSet{
            self.tweetLabel.text = tweet.text
            
            if let user = self.tweet.user{
                self.userNameLabel.text = user.screenName
            
            
            if let image = cache?.read(user.profileImageURL){
                self.profileImageView.image = image
                return
            }
            
            API.shared.getImages(user.profileImageURL, completion: { (image) in
                self.cache?.write(image, key: user.profileImageURL)
                self.profileImageView.image = image
            })
        }
    }
}
    func setupTweetCell(){
        self.profileImageView.clipsToBounds = true
        self.profileImageView.layer.cornerRadius = 15.0
        self.preservesSuperviewLayoutMargins = false
        self.separatorInset = UIEdgeInsetsMake(0.0, 10.0, 0.0, 10.0)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTweetCell()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
