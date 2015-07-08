//
//  DotExt.swift
//  AtomsV5
//
//  Created by Zack Rhodes on 7/8/15.
//  Copyright © 2015 Geodudes. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
	func spawnRedSprite(){
		redDotArray.append(SKSpriteNode(texture: redDotTexture, color: UIColor(red:CGFloat(1), green:CGFloat(0), blue:CGFloat(0.75), alpha: CGFloat(0.00)), size: CGSizeMake(CGFloat(59), CGFloat(59))))
		//PlayScene.addChild(redDotArray[redDotCount])	//???????????
		redDotArray[redDotCount].physicsBody = SKPhysicsBody(texture: redDotTexture, alphaThreshold: 0.999, size: CGSizeMake(59, 59))
		redDotArray[redDotCount].userData = NSMutableDictionary()
		redDotArray[redDotCount].physicsBody?.mass = CGFloat(0.8)
		redDotArray[redDotCount].physicsBody?.categoryBitMask = dotMask
		redDotArray[redDotCount].physicsBody?.collisionBitMask = noContactMask
		redDotArray[redDotCount].physicsBody?.contactTestBitMask = noContactMask
		redDotArray[redDotCount].physicsBody?.fieldBitMask = fieldMask
		redDotArray[redDotCount].physicsBody?.charge = -0.1
		redDotArray[redDotCount].physicsBody?.affectedByGravity = true
		redDotArray[redDotCount].physicsBody?.restitution = 0.5
		redDotArray[redDotCount].physicsBody?.linearDamping = 0.0
		redDotArray[redDotCount].position = CGPointMake(0,0)//(CGFloat(-50), CGFloat(320 + (21 * (redDotCount % 15))))
		redDotArray[redDotCount].physicsBody?.applyImpulse(CGVectorMake(CGFloat(32.0), CGFloat(-15.0 + (redDotArray[redDotCount].position.y % 15))))
		redDotCount++
		if ((redDotCount % 5) == 0) {
			print("increasing reds")
			redDotTimer.invalidate()
			redDotTimer = NSTimer.scheduledTimerWithTimeInterval(redTimeInterval, target: self, selector: Selector("spawnRedSprite"), userInfo: nil, repeats: true)
		}
	}
	
	func spawnBlueSprite(){
		blueDotArray.append(SKSpriteNode(texture: blueDotTexture, color: UIColor(red:CGFloat(0), green:CGFloat(0), blue:CGFloat(0.75), alpha: CGFloat(0.00)), size: CGSizeMake(CGFloat(59), CGFloat(59))))
		//blueDotArray[blueDotCount].colorBlendFactor = 1.0
		//PlayScene.addChild(blueDotArray[blueDotCount])
		blueDotArray[blueDotCount].physicsBody = SKPhysicsBody(texture: blueDotTexture, alphaThreshold: 0.999, size: CGSizeMake(59, 59))
		blueDotArray[blueDotCount].userData = NSMutableDictionary()
		blueDotArray[blueDotCount].physicsBody?.mass = CGFloat(0.8)
		blueDotArray[blueDotCount].physicsBody?.categoryBitMask = dotMask
		blueDotArray[blueDotCount].physicsBody?.collisionBitMask = noContactMask
		blueDotArray[blueDotCount].physicsBody?.contactTestBitMask = noContactMask
		blueDotArray[blueDotCount].physicsBody?.fieldBitMask = fieldMask
		blueDotArray[blueDotCount].physicsBody?.charge = -0.1
		blueDotArray[blueDotCount].physicsBody?.affectedByGravity = true
		blueDotArray[blueDotCount].physicsBody?.restitution = 0.5
		blueDotArray[blueDotCount].physicsBody?.linearDamping = 0.0
		blueDotArray[blueDotCount].position = CGPointMake(CGFloat(400), CGFloat(377 - (21 * (blueDotCount % 15))))
		blueDotArray[blueDotCount].physicsBody?.applyImpulse(CGVectorMake(CGFloat(-32.0), CGFloat(15.0 - (blueDotArray[blueDotCount].position.y % 15))))
		blueDotCount++
		if ((blueDotCount % 5) == 0) {
			blueDotTimer.invalidate()
			blueDotTimer = NSTimer.scheduledTimerWithTimeInterval(blueTimeInterval, target: self, selector: Selector("spawnBlueSprite"), userInfo: nil, repeats: true)
		}
	}
	
}