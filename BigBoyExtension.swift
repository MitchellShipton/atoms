//
//  BigBoyExtension.swift
//  AtomsV5
//
//  Created by Zack Rhodes on 7/8/15.
//  Copyright © 2015 Geodudes. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
	func spawnBigBoy(){
		bigBoyArray.append(SKSpriteNode(texture: bigBoyTexture, size: CGSizeMake(CGFloat(45), CGFloat(45))))
		self.addChild(bigBoyArray[bigBoyCount])
		bigBoyArray[bigBoyCount].physicsBody = SKPhysicsBody(texture: bigBoyTexture, alphaThreshold: 0.999, size: CGSizeMake(45, 45))
		bigBoyArray[bigBoyCount].alpha = 0.80
		bigBoyArray[bigBoyCount].userData = NSMutableDictionary()
		bigBoyArray[bigBoyCount].physicsBody?.mass = CGFloat(1.4)
		bigBoyArray[bigBoyCount].physicsBody?.categoryBitMask = dotMask
		bigBoyArray[bigBoyCount].physicsBody?.collisionBitMask = dotMask
		bigBoyArray[bigBoyCount].physicsBody?.contactTestBitMask = noContactMask
		bigBoyArray[bigBoyCount].physicsBody?.fieldBitMask = fieldMask
		bigBoyArray[bigBoyCount].physicsBody?.charge = -0.1
		bigBoyArray[bigBoyCount].physicsBody?.affectedByGravity = true
		bigBoyArray[bigBoyCount].physicsBody?.restitution = 0.5
		bigBoyArray[bigBoyCount].physicsBody?.linearDamping = 0.0
		if ((bigBoyCount % 2) == 0) {
			bigBoyArray[bigBoyCount].position = CGPointMake(CGFloat(400), CGFloat(365 - (25 * (bigBoyCount % 15))))
			bigBoyArray[bigBoyCount].physicsBody?.applyImpulse(CGVectorMake(CGFloat(-32.0), CGFloat(15.0 - (bigBoyArray[bigBoyCount].position.y % 15))))
		} else {
			bigBoyArray[bigBoyCount].position = CGPointMake(CGFloat(-50), CGFloat(300 + (22 * (bigBoyCount % 15))))
			bigBoyArray[bigBoyCount].physicsBody?.applyImpulse(CGVectorMake(CGFloat(32.0), CGFloat(-15.0 + (bigBoyArray[bigBoyCount].position.y % 15))))
		}
		bigBoyCount++
		//if (bigBoyCount == 15) {
		//    bigBoyTimer.invalidate()
		//}
	}
}