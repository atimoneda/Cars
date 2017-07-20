//
//  GameViewController.swift
//  Cars
//
//  Created by Arnau Timoneda Heredia on 30/5/17.
//  Copyright © 2017 Arnau Timoneda Heredia. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            //if let scene = SKScene(fileNamed: "GameScene") {
            if let scene = SKScene(fileNamed: "MainMenuScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                scene.anchorPoint = CGPoint.zero
                
                // Present the scene
                view.presentScene(scene)
            }
            
           /* let scene = GameScene(size: CGSize(width: view.frame.width, height: view.frame.height))
            scene.scaleMode = .aspectFill
            
            scene.anchorPoint = CGPoint.zero
            
            // Present the scene
            view.presentScene(scene)
            
            */
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
