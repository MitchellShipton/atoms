//
//  InitializeContainer.swift
//  AtomsV5
//
//  Created by Zack Rhodes on 7/8/15.
//  Copyright © 2015 Geodudes. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
	
	func initializeContainer(){
		initializePhysicsField()
		initializePhysicsWorld()
	}

	func initializePhysicsField(){
		fieldNode = SKFieldNode.noiseFieldWithSmoothness(CGFloat(1.0), animationSpeed: CGFloat(1.0))
		self.addChild(fieldNode)
		fieldNode.physicsBody = SKPhysicsBody(circleOfRadius: 700)
		fieldNode.position = CGPointMake(187, 332)
		fieldNode.categoryBitMask = fieldMask
		fieldNode.strength = 0.07
	}
	
	func initializePhysicsWorld(){
		physicsWorld.gravity = CGVector(dx: 0.0, dy: -0.0)
		self.physicsWorld.contactDelegate = self
		self.physicsBody = SKPhysicsBody(edgeLoopFromRect: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
		self.physicsBody?.restitution = 1.0
		self.physicsBody?.categoryBitMask = edgeMask
	}
}