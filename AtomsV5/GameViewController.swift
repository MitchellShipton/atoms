//
//  GameViewController.swift
//  AtomsV5
//
//  Created by Zack Rhodes on 7/8/15.
//  Copyright (c) 2015 Geodudes. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let scene = GameScene(fileNamed:"GameScene") {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)
        }
    }
	
	@IBOutlet var scoreCountLabel: UILabel!

	@IBAction func dragDot(sender: UIPanGestureRecognizer) {
		if sender.state == UIGestureRecognizerState.Began && dotToDrag != nil{
			dotToDrag.size = CGSizeMake(dotToDrag.size.width * 1.2, dotToDrag.size.height * 1.2)
			dotToDrag.physicsBody?.categoryBitMask = noContactMask
			dotToDrag.physicsBody?.collisionBitMask = noContactMask
			dotToDrag.physicsBody?.contactTestBitMask = cornerMask
			dotToDrag.physicsBody?.fieldBitMask = noContactMask
			dotToDrag?.physicsBody?.affectedByGravity = false
			dotToDrag?.physicsBody?.velocity =  /*CGVectorMake(sender.velocityInView(self.view).x, sender.velocityInView(self.view).y)*/
				CGVectorMake(CGFloat(0.0), CGFloat(0.0))
		}
		self.view.bringSubviewToFront(sender.view!)
		
		dotToDrag?.position = CGPoint(x: (sender.locationInView(sender.view).x), y: self.view.bounds.size.height - (sender.locationInView(sender.view).y))
		if sender.state == UIGestureRecognizerState.Ended{
			scoreCount = scoreCount + addToScoreCount
			scoreCountLabel.text = String(scoreCount)
			if dotToDrag != nil{
				dotToDrag?.size = CGSizeMake(dotToDrag.size.width / 1.2, dotToDrag.size.height / 1.2)
			}
			dotToDrag?.physicsBody?.affectedByGravity = true
			dotToDrag?.physicsBody?.fieldBitMask = fieldMask
			dotToDrag = nil
		}

	}
    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
