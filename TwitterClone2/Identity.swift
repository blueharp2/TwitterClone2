//
//  Identity.swift
//  TwitterClone2
//
//  Created by Lindsey on 6/15/16.
//  Copyright © 2016 Lindsey Boggio. All rights reserved.
//

import Foundation

protocol Identity {
    static func id() -> String
}

extension Identity{
    static func id() -> String{
        return String(self)
    }
}