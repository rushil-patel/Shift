//
//  GamePlayScene.swift
//  Shift
//
//  Created by Rushil Patel on 7/9/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

enum HeroAction {
    case Run, Jump
}

class GamePlayScene: CCNode, CCPhysicsCollisionDelegate{
    
    
    let heroSpeed: Float = 80
    
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
       
        //Load in hero into variable holder
        whiteHero  = CCBReader.load("WhiteHero") as! Hero
        blackHero = CCBReader.load("BlackHero") as! Hero
        
        //initial birth into gameplay scene
        //based off initial values set in sprite builder
        if whiteHero.activeState {
            
            blackHero.activeState = false
            
            gamePhysicsNode.addChild(whiteHero)
            activeHero = whiteHero
        }
        else if blackHero.activeState {
            
            whiteHero.activeState = false
            
            gamePhysicsNode.addChild(blackHero)
            activeHero = blackHero
        }
        
        //initialize grounds array
        grounds.append(ground1)
        grounds.append(ground2)
        
        //enable user interaction 
        userInteractionEnabled = true
    }

    
    override func update(delta: CCTime) {
        
        //increment the camera to the left to simulate movement
        gamePhysicsNode.position = ccp(gamePhysicsNode.position.x - CGFloat(heroSpeed) * CGFloat(delta), gamePhysicsNode.position.y)
        
        //set hero's velocity to maintain constant velocity
        activeHero.physicsBody.velocity = CGPoint(x: CGFloat(heroSpeed), y: activeHero.physicsBody.velocity.y)
        //reposition ground block if off screen
        revolveGround()
    
    }
    
    
    func revolveGround() {
        
        for ground in grounds {
            let groundWorldPosition = gamePhysicsNode.convertToWorldSpace(ground.position)
            let groundScreenPosition = convertToNodeSpace(groundWorldPosition)
            
            
            //boundingBox accounts for scale factor, contentSize does NOT
            if groundScreenPosition.x <= -ground.boundingBox().width {
    
                ground.position = CGPointMake(ground.position.x + ground.boundingBox().width * 2.0, ground.position.y)
            
            
            }
        }
        
    }
    
    //TODO: make sure action state is being update properly
    override func touchBegan(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        let touchPosition = touch!.locationInWorld()
        let screenHeight = CCDirector.sharedDirector().viewSize().height
        if touchPosition.x < CCDirector.sharedDirector().viewSize().width/2  {
            if activeHero.action == .Jump {
                let scale = (screenHeight - activeHero.position.y)/screenHeight + 0.2
                activeHero.physicsBody.velocity = CGPointZero
                activeHero.physicsBody.applyForce(CGPointMake(0, 90000 * scale))
            } else {
                activeHero.physicsBody.applyForce(CGPointMake(0, 80000))
                activeHero.action = .Jump
            }
        }
        else {
            toggleHero()
        }
        
    }
    
    
    func toggleHero() {
        if whiteHero.activeState {
            whiteHero.activeState = false
            
            blackHero.position = activeHero.position
            blackHero.physicsBody = whiteHero.physicsBody
            blackHero.activeState = true
            activeHero = blackHero
            
            whiteHero.removeFromParent()
            gamePhysicsNode.addChild(activeHero)
            
        }
        else {
            blackHero.activeState = false
            
            whiteHero.position = activeHero.position
            whiteHero.physicsBody = whiteHero.physicsBody
            whiteHero.activeState = true
            activeHero = whiteHero
            
            blackHero.removeFromParent()
            gamePhysicsNode.addChild(activeHero)
            
        }

        
    }
    
    override func touchMoved(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        
    }
    
    override func touchEnded(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        
    }
    
    

    
}