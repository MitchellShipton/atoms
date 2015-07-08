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

var redTimeInterval: NSTimeInterval = 3
var blueTimeInterval: NSTimeInterval = 3


class GameScene: SKScene, SKPhysicsContactDelegate {
	
	override func didMoveToView(view: SKView) {
		setupScene()
		
		//timers to spawn the dots
		redDotTimer = NSTimer.scheduledTimerWithTimeInterval(redTimeInterval, target: self, selector: Selector("spawnRedSprite"), userInfo: nil, repeats: true)
		blueDotTimer = NSTimer.scheduledTimerWithTimeInterval(blueTimeInterval, target: self, selector: Selector("spawnBlueSprite"), userInfo: nil, repeats: true)
		bigBoyTimer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: Selector("spawnBigBoy"), userInfo: nil, repeats: true)
		
		//physics field
		fieldNode = SKFieldNode.noiseFieldWithSmoothness(CGFloat(1.0), animationSpeed: CGFloat(1.0))
		self.addChild(fieldNode)
		fieldNode.physicsBody = SKPhysicsBody(circleOfRadius: 700)
		fieldNode.position = CGPointMake(187, 332)
		fieldNode.categoryBitMask = fieldMask
		fieldNode.strength = 0.07
		
		//container
		physicsWorld.gravity = CGVector(dx: 0.0, dy: -0.0)
		self.physicsWorld.contactDelegate = self
		self.physicsBody = SKPhysicsBody(edgeLoopFromRect: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
		self.physicsBody?.restitution = 1.0
		self.physicsBody?.categoryBitMask = edgeMask
		
		//corner parent
		cornerParent = self.childNodeWithName("corner_Parent")
		
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
		//redCorner.physicsBody?.mass = 1000000000000
		
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
		//blueCorner.physicsBody?.mass = 1000000000000
		
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
	
	func setupScene(){
		let bgColor = UIColor(red: CGFloat(1), green: CGFloat(0.954), blue: CGFloat(0.910), alpha: CGFloat(1))
		self.backgroundColor = bgColor
	}
	
	
	override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
		self.scene?.paused = false
		
		if let touch = touches.first {
			let location = touch.locationInNode(self)
			for SKSpriteNode in redDotArray {
				if (location.x < (SKSpriteNode.position.x + SKSpriteNode.size.width/(3.8))) && (location.x > SKSpriteNode.position.x - SKSpriteNode.size.width/3.8) {
					if (location.y < (SKSpriteNode.position.y + SKSpriteNode.size.height/3.8)) && (location.y > (SKSpriteNode.position.y - SKSpriteNode.size.height/3.8)){
						dotToDrag = SKSpriteNode
					}   }
			}
			for SKSpriteNode in blueDotArray {
				if (location.x < (SKSpriteNode.position.x + SKSpriteNode.size.width/3.8)) && (location.x > SKSpriteNode.position.x - SKSpriteNode.size.width/3.8) {
					if (location.y < (SKSpriteNode.position.y + SKSpriteNode.size.height/3.8)) && (location.y > (SKSpriteNode.position.y - SKSpriteNode.size.height/3.8)){
						dotToDrag = SKSpriteNode
					}        }   }
			for SKSpriteNode in blueBombArray {
				if (location.x < (SKSpriteNode.position.x + SKSpriteNode.size.width/3.8)) && (location.x > SKSpriteNode.position.x - SKSpriteNode.size.width/3.8) {
					if (location.y < (SKSpriteNode.position.y + SKSpriteNode.size.height/3.8)) && (location.y > (SKSpriteNode.position.y - SKSpriteNode.size.height/3.8)){
						dotToDrag = SKSpriteNode
					}        }   }
			for SKSpriteNode in redBombArray {
				if (location.x < (SKSpriteNode.position.x + SKSpriteNode.size.width/3.8)) && (location.x > SKSpriteNode.position.x - SKSpriteNode.size.width/3.8) {
					if (location.y < (SKSpriteNode.position.y + SKSpriteNode.size.height/3.8)) && (location.y > (SKSpriteNode.position.y - SKSpriteNode.size.height/3.8)){
						dotToDrag = SKSpriteNode
					}        }   }
			for SKSpriteNode in bigBoyArray {
				if (location.x < (SKSpriteNode.position.x + SKSpriteNode.size.width/3.8)) && (location.x > SKSpriteNode.position.x - SKSpriteNode.size.width/3.8) {
					if (location.y < (SKSpriteNode.position.y + SKSpriteNode.size.height/3.8)) && (location.y > (SKSpriteNode.position.y - SKSpriteNode.size.height/3.8)){
						dotToDrag = SKSpriteNode
					}        }   }
		}
		super.touchesBegan(touches , withEvent:event)
	}
	
	let blueCornerFinalPoint = CGPointMake(15, 15)
	let redCornerFinalPoint = CGPointMake(370, 650)
	var toPulseRedCorner: Int! = 0
	
	
	
	
	
	
	override func update(currentTime: CFTimeInterval) {
		/* Called before each frame is rendered */
		if redTimeInterval > 1 {
			redTimeInterval = redTimeInterval - 0.0005
		}
		if blueTimeInterval > 1 {
			blueTimeInterval = blueTimeInterval - 0.0006
		}
		
		let chanceFire = arc4random_uniform(1000)
		if (chanceFire) == 500 {
			//			spawnBlueBomb()
		}
		if (chanceFire == 250) {
			//			spawnRedBomb()
		}
		
		for SKSpriteNode in redDotArray {
			if SKSpriteNode.userData?.valueForKey("redBombed") == nil{
				SKSpriteNode.colorBlendFactor = SKSpriteNode.colorBlendFactor + 0.0015      //was at 0.0025
			}
			if (SKSpriteNode.position.x > 30) && (SKSpriteNode != dotToDrag){
				SKSpriteNode.physicsBody?.categoryBitMask = dotMask
				SKSpriteNode.physicsBody?.collisionBitMask = dotMask | cornerMask | edgeMask
			}
			if (SKSpriteNode.alpha <= 0.3){
				SKSpriteNode.removeFromParent()
			}
			if ((SKSpriteNode.userData?.valueForKey("Remove?")) != nil){
				SKSpriteNode.physicsBody?.categoryBitMask = noContactMask
				SKSpriteNode.physicsBody?.collisionBitMask = noContactMask
				SKSpriteNode.physicsBody?.contactTestBitMask = cornerMask
				if (SKSpriteNode.position.y < cornerParent.position.y){
					print(SKSpriteNode)
					self.scene?.paused = true /*
					
					if (SKSpriteNode.position.y > blueCornerFinalPoint.y) {
					SKSpriteNode.position.y = SKSpriteNode.position.y - 2
					}
					if (SKSpriteNode.position.x > blueCornerFinalPoint.x) {
					SKSpriteNode.position.x = SKSpriteNode.position.x - 2
					}
					if (SKSpriteNode.colorBlendFactor > 0) {
					SKSpriteNode.colorBlendFactor = SKSpriteNode.colorBlendFactor - 0.05
					} else {SKSpriteNode.removeFromParent()}
					*/} else {
					addToScoreCount = 1
					//                    if (toPulseRedCorner == 0){
					//                        toPulseRedCorner = 1
					//                    }
					if (SKSpriteNode.position.y < redCornerFinalPoint.y) {
						SKSpriteNode.position.y = SKSpriteNode.position.y + 2
					}
					if (SKSpriteNode.position.x < redCornerFinalPoint.x) {
						SKSpriteNode.position.x = SKSpriteNode.position.x + 2
					}
					if (SKSpriteNode.colorBlendFactor > 0) {
						//SKSpriteNode.colorBlendFactor = SKSpriteNode.colorBlendFactor - 0.05
						SKSpriteNode.alpha = SKSpriteNode.alpha - 0.1       //double check this
					} else {SKSpriteNode.removeFromParent()}
				}   } else if (SKSpriteNode.colorBlendFactor >= 1) {print(SKSpriteNode);self.scene?.paused = true}
		}
		for SKSpriteNode in blueDotArray {
			if SKSpriteNode.userData?.valueForKey("blueBombed") == nil {
				SKSpriteNode.colorBlendFactor = SKSpriteNode.colorBlendFactor + 0.0015
			}
			if (SKSpriteNode.position.x < 345) && (SKSpriteNode.position.y > 50) && (SKSpriteNode != dotToDrag){
				SKSpriteNode.physicsBody?.categoryBitMask = dotMask
				SKSpriteNode.physicsBody?.collisionBitMask = dotMask | cornerMask | edgeMask
			}
			if (SKSpriteNode.alpha <= 0.3){
				SKSpriteNode.removeFromParent()
			}
			if ((SKSpriteNode.userData?.valueForKey("Remove?")) != nil){
				//SKSpriteNode.userData?.setValue(nil, forKey: "Remove?")
				SKSpriteNode.physicsBody?.categoryBitMask = noContactMask
				SKSpriteNode.physicsBody?.collisionBitMask = noContactMask
				SKSpriteNode.physicsBody?.contactTestBitMask = cornerMask
				if (SKSpriteNode.position.y < cornerParent.position.y){
					addToScoreCount = 1
					if (SKSpriteNode.position.y > blueCornerFinalPoint.y) {
						SKSpriteNode.position.y = SKSpriteNode.position.y - 2
					}
					if (SKSpriteNode.position.x > blueCornerFinalPoint.x) {
						SKSpriteNode.position.x = SKSpriteNode.position.x - 2
					}
					if (SKSpriteNode.colorBlendFactor > 0) {
						//SKSpriteNode.colorBlendFactor = SKSpriteNode.colorBlendFactor - 0.03
						SKSpriteNode.alpha = SKSpriteNode.alpha - 0.1       //and this
					} else {SKSpriteNode.removeFromParent()}
				} else {
					print(SKSpriteNode)
					self.scene?.paused = true /*
					
					if (SKSpriteNode.position.y < redCornerFinalPoint.y) {
					SKSpriteNode.position.y = SKSpriteNode.position.y + 2
					}
					if (SKSpriteNode.position.x < redCornerFinalPoint.x) {
					SKSpriteNode.position.x = SKSpriteNode.position.x + 2
					}
					if (SKSpriteNode.colorBlendFactor > 0) {
					SKSpriteNode.colorBlendFactor = SKSpriteNode.colorBlendFactor - 0.05
					} else {SKSpriteNode.removeFromParent()}
					*/}    } else if (SKSpriteNode.colorBlendFactor >= 1) {print(SKSpriteNode);self.scene?.paused = true}
		}
		/*if (pulseRedCorner == 2){
		redCorner.colorBlendFactor = redCorner.colorBlendFactor + 0.1
		if (redCorner.colorBlendFactor >= 0.5){
		pulseRedCorner = 1
		}
		}
		if ((pulseRedCorner == 1) & (redCorner.colorBlendFactor > 0)){
		redCorner.colorBlendFactor = redCorner.colorBlendFactor - 0.1
		} else { (pulseRedCorner = 0); (toPulseRedCorner = 0) }*/
		
		for SKSpriteNode in redBombArray {
			SKSpriteNode.alpha = SKSpriteNode.alpha - 0.002      //was at 0.0025
			if (SKSpriteNode.position.x > 30) && (SKSpriteNode != dotToDrag){
				SKSpriteNode.physicsBody?.categoryBitMask = dotMask
				SKSpriteNode.physicsBody?.collisionBitMask = dotMask | cornerMask | edgeMask
			}
			if ((SKSpriteNode.userData?.valueForKey("Remove?")) != nil){
				SKSpriteNode.physicsBody?.categoryBitMask = noContactMask
				SKSpriteNode.physicsBody?.collisionBitMask = noContactMask
				SKSpriteNode.physicsBody?.contactTestBitMask = cornerMask
				if (SKSpriteNode.position.y < cornerParent.position.y){
					print(SKSpriteNode)
					self.scene?.paused = true}
				else {
					addToScoreCount = 5
					for SKSpriteNode in redDotArray{
						if (SKSpriteNode.alpha > 0) {
							SKSpriteNode.alpha = SKSpriteNode.alpha - 0.15
						}
						SKSpriteNode.userData?.setValue(1, forKey: "redBombed")
					}
					if (SKSpriteNode.position.y > blueCornerFinalPoint.y) {
						SKSpriteNode.position.y = SKSpriteNode.position.y + 2
					}
					if (SKSpriteNode.position.x > blueCornerFinalPoint.x) {
						SKSpriteNode.position.x = SKSpriteNode.position.x + 2
					}
					if (SKSpriteNode.alpha > 0) {
						//SKSpriteNode.colorBlendFactor = SKSpriteNode.colorBlendFactor - 0.05
						SKSpriteNode.alpha = SKSpriteNode.alpha - 0.08       //double check this
					} else {
						SKSpriteNode.userData?.setValue(nil, forKey: "Remove?")
						SKSpriteNode.removeFromParent()}
				}   } else if (SKSpriteNode.colorBlendFactor >= 1) {print(SKSpriteNode);self.scene?.paused = true}
		}
		
		for SKSpriteNode in blueBombArray {
			SKSpriteNode.alpha = SKSpriteNode.alpha - 0.002      //was at 0.0025
			if (SKSpriteNode.position.x < 345) && (SKSpriteNode.position.y > 50) && (SKSpriteNode != dotToDrag){
				SKSpriteNode.physicsBody?.categoryBitMask = dotMask
				SKSpriteNode.physicsBody?.collisionBitMask = dotMask | cornerMask | edgeMask
			}
			if ((SKSpriteNode.userData?.valueForKey("Remove?")) != nil){
				SKSpriteNode.physicsBody?.categoryBitMask = noContactMask
				SKSpriteNode.physicsBody?.collisionBitMask = noContactMask
				SKSpriteNode.physicsBody?.contactTestBitMask = cornerMask
				if (SKSpriteNode.position.y > cornerParent.position.y){
					print(SKSpriteNode)
					self.scene?.paused = true}
				else {
					addToScoreCount = 5
					for SKSpriteNode in blueDotArray{
						if (SKSpriteNode.alpha > 0) {
							SKSpriteNode.alpha = SKSpriteNode.alpha - 0.15
						}
						SKSpriteNode.userData?.setValue(1, forKey: "blueBombed")
					}
					if (SKSpriteNode.position.y > blueCornerFinalPoint.y) {
						SKSpriteNode.position.y = SKSpriteNode.position.y - 2
					}
					if (SKSpriteNode.position.x > blueCornerFinalPoint.x) {
						SKSpriteNode.position.x = SKSpriteNode.position.x - 2
					}
					if (SKSpriteNode.alpha > 0) {
						//SKSpriteNode.colorBlendFactor = SKSpriteNode.colorBlendFactor - 0.05
						SKSpriteNode.alpha = SKSpriteNode.alpha - 0.08       //double check this
					} else {
						SKSpriteNode.userData?.setValue(nil, forKey: "Remove?")
						SKSpriteNode.removeFromParent()}
				}   } else if (SKSpriteNode.colorBlendFactor >= 1) {print(SKSpriteNode);self.scene?.paused = true}
		}
		
		for SKSpriteNode in bigBoyArray {
			SKSpriteNode.alpha = SKSpriteNode.alpha - 0.002      //was at 0.0025
			if (SKSpriteNode.position.x < 345) && (SKSpriteNode.position.y > 50) && (SKSpriteNode.position.x > 30) && (SKSpriteNode != dotToDrag){
				SKSpriteNode.physicsBody?.categoryBitMask = dotMask
				SKSpriteNode.physicsBody?.collisionBitMask = dotMask | cornerMask | edgeMask
			}
			if ((SKSpriteNode.userData?.valueForKey("Remove?")) != nil){
				addToScoreCount = 0
				SKSpriteNode.physicsBody?.categoryBitMask = noContactMask
				SKSpriteNode.physicsBody?.collisionBitMask = noContactMask
				SKSpriteNode.physicsBody?.contactTestBitMask = cornerMask
				self.scene?.paused = true
			}
		}
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
	
	//	func spawnRedSpriteInScene() {
	//		spawnRedSprite()
	//	}
	
}
