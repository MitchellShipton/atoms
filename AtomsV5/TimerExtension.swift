//
//  TimerExtension.swift
//  AtomsV5
//
//  Created by Zack Rhodes on 7/8/15.
//  Copyright © 2015 Geodudes. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
	
	func initializeTimers(){
		//timers to spawn the dots
		redDotTimer = NSTimer.scheduledTimerWithTimeInterval(redTimeInterval, target: self, selector: Selector("spawnRedSprite"), userInfo: nil, repeats: true)
		blueDotTimer = NSTimer.scheduledTimerWithTimeInterval(blueTimeInterval, target: self, selector: Selector("spawnBlueSprite"), userInfo: nil, repeats: true)
		bigBoyTimer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: Selector("spawnBigBoy"), userInfo: nil, repeats: true)
	}
	
}