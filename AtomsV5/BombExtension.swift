//
//  BomExt.swift
//  AtomsV5
//
//  Created by Zack Rhodes on 7/8/15.
//  Copyright © 2015 Geodudes. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
	
	func spawnRedBomb(){
		redBombArray.append(SKSpriteNode(texture: redBombTexture, size: CGSizeMake(CGFloat(52), CGFloat(52))))
		self.addChild(redBombArray[redBombCount])
		redBombArray[redBombCount].physicsBody = SKPhysicsBody(texture: redBombTexture, alphaThreshold: 0.999, size: CGSizeMake(52, 52))
		redBombArray[redBombCount].userData = NSMutableDictionary()
		//redBombArray[redBombCount].setValue(2, forKey: "Type")
		redBombArray[redBombCount].physicsBody?.mass = CGFloat(1.1)
		redBombArray[redBombCount].physicsBody?.categoryBitMask = dotMask
		redBombArray[redBombCount].physicsBody?.collisionBitMask = dotMask
		redBombArray[redBombCount].physicsBody?.contactTestBitMask = noContactMask
		redBombArray[redBombCount].physicsBody?.fieldBitMask = fieldMask
		redBombArray[redBombCount].physicsBody?.charge = -0.1
		redBombArray[redBombCount].physicsBody?.affectedByGravity = true
		redBombArray[redBombCount].physicsBody?.restitution = 0.5
		redBombArray[redBombCount].physicsBody?.linearDamping = 0.0
		redBombArray[redBombCount].position = CGPointMake(CGFloat(-50), CGFloat(300 + (22 * (redDotCount % 15))))
		redBombArray[redBombCount].physicsBody?.applyImpulse(CGVectorMake(CGFloat(32.0), CGFloat(-15.0 + (redBombArray[redBombCount].position.y % 15))))
		redBombCount++
		if (redBombCount == 15) {
			redBombTimer.invalidate()
		}
	}
	
	func spawnBlueBomb(){
		blueBombArray.append(SKSpriteNode(texture: blueBombTexture, size: CGSizeMake(CGFloat(52), CGFloat(52))))
		self.addChild(blueBombArray[blueBombCount])
		blueBombArray[blueBombCount].physicsBody = SKPhysicsBody(texture: blueBombTexture, alphaThreshold: 0.999, size: CGSizeMake(52, 52))
		blueBombArray[blueBombCount].userData = NSMutableDictionary()
		blueBombArray[blueBombCount].physicsBody?.mass = CGFloat(1.1)
		blueBombArray[blueBombCount].physicsBody?.categoryBitMask = dotMask
		blueBombArray[blueBombCount].physicsBody?.collisionBitMask = dotMask
		blueBombArray[blueBombCount].physicsBody?.contactTestBitMask = noContactMask
		blueBombArray[blueBombCount].physicsBody?.fieldBitMask = fieldMask
		blueBombArray[blueBombCount].physicsBody?.charge = -0.1
		blueBombArray[blueBombCount].physicsBody?.affectedByGravity = true
		blueBombArray[blueBombCount].physicsBody?.restitution = 0.5
		blueBombArray[blueBombCount].physicsBody?.linearDamping = 0.0
		blueBombArray[blueBombCount].position = CGPointMake(CGFloat(400), CGFloat(365 - (25 * (blueBombCount % 15))))
		blueBombArray[blueBombCount].physicsBody?.applyImpulse(CGVectorMake(CGFloat(-32.0), CGFloat(15.0 - (blueBombArray[blueBombCount].position.y % 15))))
		blueBombCount++
		if (blueBombCount == 15) {
			blueBombTimer.invalidate()
		}
	}
	
}