//
//  CornerExtensions.swift
//  AtomsV5
//
//  Created by Zack Rhodes on 7/8/15.
//  Copyright © 2015 Geodudes. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
	
	func initializeAllCorners(){
		initializeCornerParent()
		initializeRedCorner()
		initializeBlueCorner()
		initializeDetectRedCorner()
		initializeDetectBlueCorner()
	}
	
	func initializeCornerParent(){
		//corner parent
		cornerParent = self.childNodeWithName("corner_Parent")
	}
	
	func initializeRedCorner(){
		//red corner
		redCorner = cornerParent.childNodeWithName("red_Corner") as! SKSpriteNode
		redCorner.physicsBody = SKPhysicsBody(texture: redCorner.texture!, alphaThreshold: 0.99, size: redCorner.size)
		redCorner.color = UIColor(red: 0.7, green: 0.15, blue: 0.60, alpha: 0.0)
		redCorner.colorBlendFactor = 0.2
		redCorner.physicsBody?.affectedByGravity = false
		redCorner.physicsBody?.categoryBitMask = cornerMask
		//redCorner.physicsBody?.collisionBitMask = dotMask
		redCorner.physicsBody?.contactTestBitMask = noContactMask
		redCorner.physicsBody?.fieldBitMask = noContactMask
		redCorner.physicsBody?.dynamic = false
	}
	
	func initializeBlueCorner(){
		//blue corner
		blueCorner = cornerParent.childNodeWithName("blue_Corner") as! SKSpriteNode
		blueCorner.physicsBody = SKPhysicsBody(texture: blueCorner.texture!, alphaThreshold: 0.99, size: blueCorner.size)
		blueCorner.color = UIColor(red: 0, green: 0, blue: 1, alpha: 0.0)
		blueCorner.colorBlendFactor = 0.45
		blueCorner.physicsBody?.affectedByGravity = false
		blueCorner.physicsBody?.categoryBitMask = cornerMask
		//blueCorner.physicsBody?.collisionBitMask = dotMask
		blueCorner.physicsBody?.contactTestBitMask = noContactMask
		blueCorner.physicsBody?.fieldBitMask = noContactMask
		blueCorner.physicsBody?.dynamic = false
	}
	
	func initializeDetectRedCorner(){
		//detect red corner
		detectRedCorner = cornerParent.childNodeWithName("detectRed_Corner") as! SKSpriteNode
		detectRedCorner.physicsBody = SKPhysicsBody(texture: redCorner.texture!, alphaThreshold: 0.99, size: detectRedCorner.size)
		detectRedCorner.color = UIColor(red: 1, green: 0.954, blue: 0.910, alpha: 0)
		detectRedCorner.colorBlendFactor = 1
		detectRedCorner.physicsBody?.affectedByGravity = false
		detectRedCorner.physicsBody?.dynamic = false
		detectRedCorner.physicsBody?.categoryBitMask = cornerMask
		detectRedCorner.physicsBody?.collisionBitMask = noContactMask
		detectRedCorner.physicsBody?.contactTestBitMask = noContactMask
		detectRedCorner.physicsBody?.fieldBitMask = noContactMask
	}
	
	func initializeDetectBlueCorner(){
		//detect blue corner
		detectBlueCorner = cornerParent.childNodeWithName("detectBlue_Corner") as! SKSpriteNode
		detectBlueCorner.physicsBody = SKPhysicsBody(texture: blueCorner.texture!, alphaThreshold: 0.99, size: detectBlueCorner.size)
		detectBlueCorner.color = UIColor(red: 1, green: 0.954, blue: 0.910, alpha: 0)
		detectBlueCorner.colorBlendFactor = 1
		detectBlueCorner.physicsBody?.affectedByGravity = false
		detectBlueCorner.physicsBody?.dynamic = false
		detectBlueCorner.physicsBody?.categoryBitMask = cornerMask
		detectBlueCorner.physicsBody?.collisionBitMask = noContactMask
		detectBlueCorner.physicsBody?.contactTestBitMask = noContactMask
		detectBlueCorner.physicsBody?.fieldBitMask = noContactMask
	}

}