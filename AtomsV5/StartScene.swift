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
	
	let startButton = SKSpriteNode(imageNamed: "Start")
	let scoreButton = SKSpriteNode(imageNamed: "Scores")

	override func didMoveToView(view: SKView) {
		
		setupScene()
		
		let scale = 0.04 as CGFloat
		let endX = self.frame.width/12
		let startPoint = CGPointMake(2*endX, 4*self.frame.height/7)

		let actionDelta = SKAction.moveByX(2*endX, y: 0, duration: 0.3)
		let actionDelta2 = SKAction.moveByX(4*endX, y: 0, duration: 0.6)
		let actionDelta3 = SKAction.moveByX(6*endX, y: 0, duration: 0.9)
		let actionDelta4 = SKAction.moveByX(8*endX, y: 0, duration: 1.2)
		let nodeFade = SKAction.fadeAlphaTo(0.7, duration: 1.0)
		let actionWaitDot = SKAction.waitForDuration(0.25)
		
		let titleDot5 = SKSpriteNode(imageNamed: "TitleDot5")
		titleDot5.name = "titleDot5"
		titleDot5.position = startPoint
		titleDot5.xScale = scale
		titleDot5.yScale = scale
		titleDot5.alpha = 0.1
		titleDot5.runAction(SKAction.sequence([actionWaitDot, actionDelta4, nodeFade]))
		self.addChild(titleDot5)
		
		let titleDot4 = SKSpriteNode(imageNamed: "TitleDot4")
		titleDot4.name = "titleDot4"
		titleDot4.position = startPoint
		titleDot4.xScale = scale
		titleDot4.yScale = scale
		titleDot4.alpha = 0.1
		titleDot4.runAction(SKAction.sequence([actionWaitDot, actionDelta3, nodeFade]))
		self.addChild(titleDot4)
		
		let titleDot3 = SKSpriteNode(imageNamed: "TitleDot3")
		titleDot3.name = "titleDot3"
		titleDot3.position = startPoint
		titleDot3.xScale = scale
		titleDot3.yScale = scale
		titleDot3.alpha = 0.1
		titleDot3.runAction(SKAction.sequence([actionWaitDot, actionDelta2, nodeFade]))
		self.addChild(titleDot3)
		
		let titleDot2 = SKSpriteNode(imageNamed: "TitleDot2")
		titleDot2.name = "titleDot2"
		titleDot2.position = startPoint
		titleDot2.xScale = scale
		titleDot2.yScale = scale
		titleDot2.alpha = 0.1
		titleDot2.runAction(SKAction.sequence([actionWaitDot, actionDelta, nodeFade]))
		self.addChild(titleDot2)
		
		let titleDot1 = SKSpriteNode(imageNamed: "TitleDot1")
		titleDot1.name = "titleDot1"
		titleDot1.position = startPoint
		titleDot1.xScale = scale
		titleDot1.yScale = scale
		titleDot1.alpha = 0.1
		titleDot1.runAction(SKAction.sequence([actionWaitDot, nodeFade]))
		self.addChild(titleDot1)
		
		startButton.name = "startButton"
		startButton.position = CGPointMake(self.frame.width/2, 4.0*self.frame.height/7)
		startButton.xScale = 0.06
		startButton.yScale = 0.06
		startButton.alpha = 0
		let actionWait = SKAction.waitForDuration(0.74)
		let startAction = SKAction.moveToY(3.1*self.frame.height/7, duration: 0.6)
		startButton.runAction(SKAction.sequence([actionWait, startAction, nodeFade]))
		self.addChild(startButton)
		
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
					startButton.alpha = 1.0
					//self.gameVCDelagate.presentGameViewController()
					
					
						let transition = SKTransition.revealWithDirection(SKTransitionDirection.Down, duration: 1.0)
						
						let scene = GameScene.unarchiveFromFile("GameScene")! as! GameScene
						scene.scaleMode = SKSceneScaleMode.AspectFill
						
						self.scene!.view!.presentScene(scene, transition: transition)
					
				
		
			
				}else if theNode == "scoreButton" {
					scoreButton.alpha = 1.0
					//self.gameVCDelagate.presentGameViewController()
				}
			}
		}
		super.touchesBegan(touches , withEvent:event)
	}
	
	override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
		startButton.alpha = 0.7
		scoreButton.alpha = 0.7
	}

	func setupScene(){
		let bgColor = UIColor(red: CGFloat(0.9373), green: CGFloat(0.9334), blue: CGFloat(0.9608), alpha: CGFloat(1))
		self.backgroundColor = bgColor
	}
	
}