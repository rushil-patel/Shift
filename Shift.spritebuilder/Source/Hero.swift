//
//  Hero.swift
//  Shift
//
//  Created by Rushil Patel on 7/9/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation


class Hero: CCNode {
    
    
    var action: HeroAction = .Run
    
    //tracks the activity state of this hero
    //true if active (present in gameplayscene)
    //false if inactive (not present in gameplayscene)
    var activeState: Bool = false {
        didSet {
            self.visible = activeState
        }
    }

    func didLoadFromCCB() {
        //set starting position 
        self.position = CGPointMake(CCDirector.sharedDirector().viewSize().width/5, 59)
        
    }
    

}
