//
//  API.swift
//  TwitterClone2
//
//  Created by Lindsey on 6/14/16.
//  Copyright © 2016 Lindsey Boggio. All rights reserved.
//

import Foundation
import Accounts
import Social

class API{
    
    static let shared = API()
    
    var account: ACAccount?
    
    private func logIn(completion: (account: ACAccount?) ->()){
        //Set up Account Store
        let accountstore = ACAccountStore()
        
        //Give Account Store an account type - in this case Twitter
        let accountType = accountstore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        
        //Make a request and deal with the possiblities of errors, granted access, no twitter account found on device, and user did not authorize Twitter account to be used
        accountstore.requestAccessToAccountsWithType(accountType, options: nil, completion:  { (granted, error) -> Void in
            
            if let _ = error{
                print("ERROR: Request to access account returned an error")
                completion(account: nil)
                return
                }
            
            if granted{
                if let account = accountstore.accountsWithAccountType(accountType).first as? ACAccount{
                    completion(account: account)
                }
                
                print("Error: No Twitter accounts were found on this device")
                completion(account: nil)
                return
            }
            
            print("Error: This app requires access to the Twitter Accounts")
            completion(account: nil)
            return
        })
    }
    
    private func GETOAuthUser(completion:(user:User?) ->()){
        
        let request  = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .GET, URL: NSURL (string:"https://api.twitter.com/1.1/account/verify_credentials.json"), parameters: nil)
        
        request.account = self.account
        
        request.performRequestWithHandler { (data, response, error) in
           
            if let _ = error{
                print("ERROR: SLRequest could not get credentials")
                completion(user: nil)
                return
            }
            
            switch response.statusCode{
            case 200...299:
                
                do{
                    if let userJSON = try NSJSONSerialization.JSONObjectWithData(data, options:.MutableContainers) as? [String:AnyObject]{
                        completion(user: User(json: userJSON))
                    }
                } catch {
                    print("Error: Could not serialize JSON")
                    completion(user: nil)
                }
                
            case 400...499:
                print("Client Error: \(response.statusCode)")
                completion(user: nil)
            case 500...599:
                print("Server Error: \(response.statusCode)")
                completion(user: nil)
            default:
                print("Error: \(response.statusCode)")
                completion(user: nil)
            }

        }
        
    }
    
    
    
    
}