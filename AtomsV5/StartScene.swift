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

		let actionDelta = SKAction.moveByX(2*endX, y: 0, duration: 0.3)
		let actionDelta2 = SKAction.moveByX(4*endX, y: 0, duration: 0.6)
		let actionDelta3 = SKAction.moveByX(6*endX, y: 0, duration: 0.9)
		let actionDelta4 = SKAction.moveByX(8*endX, y: 0, duration: 1.2)
		let nodeFade = SKAction.fadeAlphaTo(1, duration: 2)

		let titleDot5 = SKSpriteNode(imageNamed: "TitleDot5")
		titleDot5.name = "titleDot5"
		titleDot5.position = startPoint
		titleDot5.xScale = scale
		titleDot5.yScale = scale
		titleDot5.alpha = 0.1
		titleDot5.runAction(actionDelta4)
		titleDot5.runAction(nodeFade)
		self.addChild(titleDot5)
		
		let titleDot4 = SKSpriteNode(imageNamed: "TitleDot4")
		titleDot4.name = "titleDot4"
		titleDot4.position = startPoint
		titleDot4.xScale = scale
		titleDot4.yScale = scale
		titleDot4.alpha = 0.1
		titleDot4.runAction(actionDelta3)
		titleDot4.runAction(nodeFade)
		self.addChild(titleDot4)
		
		let titleDot3 = SKSpriteNode(imageNamed: "TitleDot3")
		titleDot3.name = "titleDot3"
		titleDot3.position = startPoint
		titleDot3.xScale = scale
		titleDot3.yScale = scale
		titleDot3.alpha = 0.1
		titleDot3.runAction(actionDelta2)
		titleDot3.runAction(nodeFade)
		self.addChild(titleDot3)
		
		let titleDot2 = SKSpriteNode(imageNamed: "TitleDot2")
		titleDot2.name = "titleDot2"
		titleDot2.position = startPoint
		titleDot2.xScale = scale
		titleDot2.yScale = scale
		titleDot2.alpha = 0.1
		titleDot2.runAction(actionDelta)
		titleDot2.runAction(nodeFade)
		self.addChild(titleDot2)
		
		let titleDot1 = SKSpriteNode(imageNamed: "TitleDot1")
		titleDot1.name = "titleDot1"
		titleDot1.position = startPoint
		titleDot1.xScale = scale
		titleDot1.yScale = scale
		titleDot1.alpha = 0.1
		titleDot1.runAction(nodeFade)
		self.addChild(titleDot1)
		
		let startButton = SKSpriteNode(imageNamed: "Start")
		startButton.name = "startButton"
		startButton.position = CGPointMake(self.frame.width/2, 4.0*self.frame.height/7)
		startButton.xScale = 0.06
		startButton.yScale = 0.06
		startButton.alpha = 0
		let actionWait = SKAction.waitForDuration(0.4)
		let startAction = SKAction.moveToY(3.1*self.frame.height/7, duration: 0.6)
		startButton.runAction(SKAction.sequence([actionWait, startAction, nodeFade]))
		self.addChild(startButton)
		
		let scoreButton = SKSpriteNode(imageNamed: "Scores")
		scoreButton.name = "scoreButton"
		scoreButton.position = CGPointMake(self.frame.width/2, 3.1*self.frame.height/7)
		scoreButton.xScale = 0.06
		scoreButton.yScale = 0.06
		scoreButton.alpha = 0
		let scoreAction = SKAction.moveToY(2.6*self.frame.height/7, duration: 0.8)
		scoreButton.runAction(SKAction.sequence([actionWait, scoreAction, nodeFade]))
		self.addChild(scoreButton)
	}
	
	override func update(currentTime: CFTimeInterval) {
	}
	
	var gameVCDelagate = StartViewController()
	
	override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
		if let touch = touches.first {
			let location = touch.locationInNode(self)
			if let theNode = self.nodeAtPoint(location).name{
				if theNode == "startButton" {
					self.gameVCDelagate.presentGameViewController()
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