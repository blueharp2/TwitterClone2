//
//  ProfileViewController.swift
//  TwitterClone2
//
//  Created by Lindsey on 6/15/16.
//  Copyright © 2016 Lindsey Boggio. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, Identity {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    var user = User?()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.update()
        
//        if let user = self.user{
//            self.userNameLabel.text = user.name
//            self.locationLabel.text = user.location
//        }
    }
    
    func update(){
        API.shared.GETOAuthUser { (user) in
            if let user = user{
                self.user = user
            }
        }
    }
    
    

    @IBAction func closeButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
