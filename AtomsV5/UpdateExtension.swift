//
//  UpdateExtension.swift
//  AtomsV5
//
//  Created by Zack Rhodes on 7/8/15.
//  Copyright © 2015 Geodudes. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
	
	func updateAllDotArrays(){
		updateRedDotArray()
		updateBlueDotArray()
		updateRedBombArray()
		updateBlueBombarray()
		updateBigBoyArray()
	}
	
	func updateRedDotArray(){
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
					self.scene?.paused = true
				}else {
					addToScoreCount = 1
				//if (toPulseRedCorner == 0){
				//    toPulseRedCorner = 1
				//}
					if (SKSpriteNode.position.y < redCornerFinalPoint.y) {
						SKSpriteNode.position.y = SKSpriteNode.position.y + 2
					}
					if (SKSpriteNode.position.x < redCornerFinalPoint.x) {
						SKSpriteNode.position.x = SKSpriteNode.position.x + 2
					}
					if (SKSpriteNode.colorBlendFactor > 0) {
						SKSpriteNode.alpha = SKSpriteNode.alpha - 0.1       //double check this
					} else {SKSpriteNode.removeFromParent()}
				}
			}else if (SKSpriteNode.colorBlendFactor >= 1) {print(SKSpriteNode);self.scene?.paused = true}
		}
	}
	
	func updateBlueDotArray(){
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
						SKSpriteNode.alpha = SKSpriteNode.alpha - 0.1  //.
					} else {SKSpriteNode.removeFromParent()}
				} else {
					print(SKSpriteNode)
					//self.scene?.paused = true
				}
			}else if (SKSpriteNode.colorBlendFactor >= 1) {print(SKSpriteNode);self.scene?.paused = true}
		}
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
	
	func updateRedBombArray(){
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
					self.scene?.paused = true
				}else {
				addToScoreCount = 5
				for SKSpriteNode in redDotArray{
					if (SKSpriteNode.alpha > 0) {
						SKSpriteNode.alpha = SKSpriteNode.alpha - 0.15
					}
					SKSpriteNode.userData?.setValue(1, forKey: "redBombed")
					
					
					SKSpriteNode.physicsBody?.categoryBitMask = noContactMask
					SKSpriteNode.physicsBody?.collisionBitMask = noContactMask
					SKSpriteNode.physicsBody?.contactTestBitMask = cornerMask
//					if (SKSpriteNode.position.y < cornerParent.position.y){
//						print(SKSpriteNode)
//						self.scene?.paused = true
//					}else {
					
						addToScoreCount = 1
						//if (toPulseRedCorner == 0){
						//    toPulseRedCorner = 1
						//}
						if (SKSpriteNode.position.y < redCornerFinalPoint.y) {
							SKSpriteNode.position.y = SKSpriteNode.position.y + 2
						}
						if (SKSpriteNode.position.x < redCornerFinalPoint.x) {
							SKSpriteNode.position.x = SKSpriteNode.position.x + 2
						}
						if (SKSpriteNode.colorBlendFactor > 0) {
							SKSpriteNode.alpha = SKSpriteNode.alpha - 0.0001       //double check this
						} else {SKSpriteNode.removeFromParent()}
					}
					
				//}
				if (SKSpriteNode.position.y > redCornerFinalPoint.y) {
					SKSpriteNode.position.y = SKSpriteNode.position.y + 2
				}
				if (SKSpriteNode.position.x > redCornerFinalPoint.x) {
					SKSpriteNode.position.x = SKSpriteNode.position.x + 2
				}
				if (SKSpriteNode.alpha > 0) {
					//SKSpriteNode.colorBlendFactor = SKSpriteNode.colorBlendFactor - 0.05
					SKSpriteNode.alpha = SKSpriteNode.alpha - 0.08       //double check this
				} else {
					SKSpriteNode.userData?.setValue(nil, forKey: "Remove?")
					SKSpriteNode.removeFromParent()}
				}
			} else if (SKSpriteNode.colorBlendFactor >= 1) {print(SKSpriteNode);self.scene?.paused = true}
		}
	}
	
	func updateBlueBombarray(){
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
							SKSpriteNode.userData?.setValue(1, forKey: "Remove?")
						}
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
					}
			} else if (SKSpriteNode.colorBlendFactor >= 1) {print(SKSpriteNode);self.scene?.paused = true}
		}
	}

	func updateBigBoyArray(){
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

}