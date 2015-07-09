//
//  StartViewController.swift
//  AtomsV5
//
//  Created by Zack Rhodes on 7/8/15.
//  Copyright (c) 2015 Geodudes. All rights reserved.
//

import UIKit
import SpriteKit

extension SKNode {
	class func unarchiveFromFile(file : NSString) -> SKNode? {
		if let path = NSBundle.mainBundle().pathForResource(file as String, ofType: "sks") {
			let sceneData = try! NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe)
			let archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
			
			archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
			let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! SKNode
			archiver.finishDecoding()
			return scene
		} else {
			return nil
		}
	}
}

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
	
	@IBAction func startButton(sender: UIButton) {
		
	}
	
	func presentGameViewController(){
		//self.performSegueWithIdentifier("startToGameSegue", sender: self)
//		if let scene2 = GameScene(fileNamed:"GameScene") {
//			// Configure the view.
//			let skView2 = self.view as! SKView
//			skView2.showsFPS = false
//			skView2.showsNodeCount = false
//			
//			/* Sprite Kit applies additional optimizations to improve rendering performance */
//			skView2.ignoresSiblingOrder = true
//			
//			/* Set the scale mode to scale to fit the window */
//			scene2.scaleMode = .AspectFill
//			
//			skView2.presentScene(scene2)
//		}
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
