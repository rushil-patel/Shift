//
//  GamePlayScene.swift
//  Shift
//
//  Created by Rushil Patel on 7/9/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation


class GamePlayScene: CCNode, CCPhysicsCollisionDelegate{
    
    //ground code connections
    weak var ground1: CCSprite!
    weak var ground2: CCSprite!
    var grounds = [CCSprite]()
    
    
    //game physics node connections
    weak var gamePhysicsNode: CCPhysicsNode!
    
    //hero holders 
    var whiteHero: Hero!
    var blackHero: Hero!
    var activeHero: Hero!
    
    
    //create actionfollow action
    var actionFollow: CCActionFollow?
    
    //wrapper content node for gamplay scene
    //everything in wrapper node will move off screen relative to action follow
    weak var gameContentNode: CCNode!
    
    func didLoadFromCCB() {
        gamePhysicsNode.debugDraw = true
        whiteHero  = CCBReader.load("WhiteHero") as! Hero
       // blackHero = CCBReader.load("BlackHero") as! Hero
        
        if whiteHero.state {
            gamePhysicsNode.addChild(whiteHero)
            activeHero = whiteHero
        }
        else if blackHero.state {
            gamePhysicsNode.addChild(blackHero)
            activeHero = blackHero
        }
        
        let actionFollow = CCActionFollow(target: activeHero, worldBoundary: self.boundingBox())
        gameContentNode.runAction(actionFollow)
        

        
    }

    override func update(delta: CCTime) {
        activeHero.physicsBody.velocity = CGPointMake(400, 0)
        
    }
    
}