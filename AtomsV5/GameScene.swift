//
//  GameScene.swift
//  Atoms
//
//  Created by Zack Rhodes on 12/29/14.
//  Copyright (c) 2014 Zack Rhodes. All rights reserved.
//

import SpriteKit

//physics field
var fieldNode: SKFieldNode!

//corners
var cornerParent: SKNode!
var redCorner: SKSpriteNode!
var blueCorner: SKSpriteNode!
var detectBlueCorner: SKSpriteNode!
var detectRedCorner: SKSpriteNode!

//red dots
var redDotArray:[SKSpriteNode] = [SKSpriteNode]()
var redDotTexture = SKTexture(imageNamed: "RedDot1.png")
var redDotTimer = NSTimer()
var redDotCount = 0

//red bomb
var redBombArray:[SKSpriteNode] = [SKSpriteNode]()
var redBombTexture = SKTexture(imageNamed: "RedBomb1.png")
var redBombTimer = NSTimer()
var redBombCount = 0

//blue dots
var blueDotArray:[SKSpriteNode] = [SKSpriteNode]()
var blueDotTexture = SKTexture(imageNamed: "BlueDot1.png")
var blueDotTimer = NSTimer()
var blueDotCount = 0

//blue bomb
var blueBombArray:[SKSpriteNode] = [SKSpriteNode]()
var blueBombTexture = SKTexture(imageNamed: "BlueBomb1.png")
var blueBombTimer = NSTimer()
var blueBombCount = 0

//big boy
var bigBoyArray:[SKSpriteNode] = [SKSpriteNode]()
var bigBoyTexture = SKTexture(imageNamed: "BigBoy.png")
var bigBoyTimer = NSTimer()
var bigBoyCount = 0

//dotToDrag
var dotToDrag: SKSpriteNode!

//masks
let dotMask: UInt32 = (0x1 << 0)
let cornerMask: UInt32 = (0x1 << 1)
let fieldMask: UInt32 = (0x1 << 2)
let noContactMask: UInt32 = (0x1 << 3)
let edgeMask: UInt32 = (0x1 << 4)

var pulseRedCorner:Int = 0
var pulseBlueCorner = 0

var scoreCount = 0
var addToScoreCount = 0

var redTimeInterval: NSTimeInterval = 2
var blueTimeInterval: NSTimeInterval = 2

let blueCornerFinalPoint = CGPointMake(15, 15)
let redCornerFinalPoint = CGPointMake(370, 650)
var toPulseRedCorner: Int! = 0


class GameScene: SKScene, SKPhysicsContactDelegate {
	
	override func didMoveToView(view: SKView) {
		setupScene()
		self.initializeTimers()
		self.initializeContainer()
		self.initializeCorners()
	}
	
	func setupScene(){
		let bgColor = UIColor(red: CGFloat(0.9373), green: CGFloat(0.9334), blue: CGFloat(0.9608), alpha: CGFloat(1))
		self.backgroundColor = bgColor
	}
	
	override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
		self.scene?.paused = false
		
		if let touch = touches.first {
			let location = touch.locationInNode(self)
			checkIfTouchingDot(location)
		}
		super.touchesBegan(touches , withEvent:event)
	}
	
	func checkIfTouchingDot(location: CGPoint){
		checkIfTouchingDot(location, dotArray: redDotArray)
		checkIfTouchingDot(location, dotArray: blueDotArray)
		checkIfTouchingDot(location, dotArray: blueBombArray)
		checkIfTouchingDot(location, dotArray: redBombArray)
		checkIfTouchingDot(location, dotArray: bigBoyArray)
	}
	
	func checkIfTouchingDot(location: CGPoint, dotArray: [SKSpriteNode])->Bool{
		for SKSpriteNode in dotArray {
			if (location.x < (SKSpriteNode.position.x + SKSpriteNode.size.width/(3.8))) && (location.x > SKSpriteNode.position.x - SKSpriteNode.size.width/3.8) {
				if (location.y < (SKSpriteNode.position.y + SKSpriteNode.size.height/3.8)) && (location.y > (SKSpriteNode.position.y - SKSpriteNode.size.height/3.8)){
					dotToDrag = SKSpriteNode
					return true
				}
			}
		}
		return false
	}
	
	override func update(currentTime: CFTimeInterval) {
		/* Called before each frame is rendered */
		if redTimeInterval > 1 {
			redTimeInterval = redTimeInterval - 0.0005
		}
		if blueTimeInterval > 1 {
			blueTimeInterval = blueTimeInterval - 0.0006
		}
		
		let chanceFire = arc4random_uniform(520)
		if (chanceFire) == 500 {
				spawnBlueBomb()
		}
		if (chanceFire == 250) {
				spawnRedBomb()
		}
		
		self.updateAllDotArrays()
	}
	
	func didBeginContact(contact: SKPhysicsContact) {
		if ((contact.bodyA.node == detectBlueCorner) || (contact.bodyA.node == detectRedCorner)){
			contact.bodyB.node?.userData?.setValue(1, forKey: "Remove?")
		} else if ((contact.bodyB.node == (detectBlueCorner)) || (contact.bodyA.node == detectRedCorner)) {
			contact.bodyA.node?.userData?.setValue(1, forKey: "Remove?")
		}
	}
	
	override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
		//println("Pulsing?")
		//if (toPulseRedCorner == 1){
		//    pulseRedCorner = 2
		//}
	}
	
}
