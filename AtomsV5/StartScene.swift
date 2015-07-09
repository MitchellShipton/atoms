//
//  StartScene.swift
//  AtomsV5
//
//  Created by Zack Rhodes on 7/8/15.
//  Copyright © 2015 Geodudes. All rights reserved.
//

import Foundation
import SpriteKit

class StartScene: SKScene {
	
	override func didMoveToView(view: SKView) {
		
		setupScene()
		
		let scale = 0.04 as CGFloat
		let endX = self.frame.width/12
		let startPoint = CGPointMake(2*endX, 4*self.frame.height/7)

		let actionDelta = SKAction.moveByX(2*endX, y: 0, duration: 0.5)
		let actionDelta2 = SKAction.moveByX(4*endX, y: 0, duration: 1)
		let actionDelta3 = SKAction.moveByX(6*endX, y: 0, duration: 1.5)
		let actionDelta4 = SKAction.moveByX(8*endX, y: 0, duration: 2)

		let titleDot5 = SKSpriteNode(imageNamed: "TitleDot5")
		titleDot5.name = "titleDot5"
		print(titleDot5.name)
		titleDot5.position = startPoint
		titleDot5.xScale = scale
		titleDot5.yScale = scale
		titleDot5.runAction(actionDelta4)
		self.addChild(titleDot5)
		
		let titleDot4 = SKSpriteNode(imageNamed: "TitleDot4")
		titleDot4.name = "titleDot4"
		titleDot4.position = startPoint
		titleDot4.xScale = scale
		titleDot4.yScale = scale
		titleDot4.runAction(actionDelta3)
		self.addChild(titleDot4)
		
		let titleDot3 = SKSpriteNode(imageNamed: "TitleDot3")
		titleDot3.name = "titleDot3"
		titleDot3.position = startPoint
		titleDot3.xScale = scale
		titleDot3.yScale = scale
		titleDot3.runAction(actionDelta2)
		self.addChild(titleDot3)
		
		let titleDot2 = SKSpriteNode(imageNamed: "TitleDot2")
		titleDot2.name = "titleDot2"
		titleDot2.position = startPoint
		titleDot2.xScale = scale
		titleDot2.yScale = scale
		titleDot2.runAction(actionDelta)
		self.addChild(titleDot2)
		
		let titleDot1 = SKSpriteNode(imageNamed: "TitleDot1")
		titleDot1.name = "titleDot1"
		titleDot1.position = startPoint
		titleDot1.xScale = scale
		titleDot1.yScale = scale
		self.addChild(titleDot1)
		
	}
	
	override func update(currentTime: CFTimeInterval) {
	}
	
	override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
		if let touch = touches.first {
			let location = touch.locationInNode(self)
			if let theNode = self.nodeAtPoint(location).name{
				if theNode == "startButton" {
				}
			}
		}
		super.touchesBegan(touches , withEvent:event)
	}

	func setupScene(){
		let bgColor = UIColor(red: CGFloat(0.9373), green: CGFloat(0.9334), blue: CGFloat(0.9608), alpha: CGFloat(1))
		self.backgroundColor = bgColor
	}
	
}