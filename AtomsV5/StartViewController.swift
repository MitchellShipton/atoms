//
//  StartViewController.swift
//  AtomsV5
//
//  Created by Zack Rhodes on 7/8/15.
//  Copyright (c) 2015 Geodudes. All rights reserved.
//

import UIKit
import SpriteKit

class StartViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		if let scene = StartScene(fileNamed:"StartScene") {
			// Configure the view.
			let skView = self.view as! SKView
			skView.showsFPS = false
			skView.showsNodeCount = false
			
			/* Sprite Kit applies additional optimizations to improve rendering performance */
			skView.ignoresSiblingOrder = true
			
			/* Set the scale mode to scale to fit the window */
			scene.scaleMode = .AspectFill
			
			skView.presentScene(scene)
		}
	}
	
	func presentGameViewController(){
		performSegueWithIdentifier("startToGameSegue", sender: self)
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
