//
//  Hero.swift
//  Shift
//
//  Created by Rushil Patel on 7/9/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation


class Hero: CCNode {
    
    var state: Bool = false {
        didSet {
            self.visible = state
        }
    }

    func didLoadFromCCB() {
        //set starting position 
        self.position = CGPointMake(CCDirector.sharedDirector().viewSize().width/5, 59)
    }
    

}
