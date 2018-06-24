//
//  MainMenuScene.swift
//  Cars
//
//  Created by Arnau Timoneda Heredia on 16/7/17.
//  Copyright © 2017 Arnau Timoneda Heredia. All rights reserved.
//

import Foundation
import SpriteKit

class MainMenuScene: SKScene {
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor(red: 0.3, green: 0.7, blue: 0.3, alpha: 1)
        
        let title:SKLabelNode = SKLabelNode()
        
        title.fontName = "AvenirNext-Regular"
        //title.fontName = "Arial"
        title.fontSize = 200
        title.text = "Cars"
        title.alpha = 1
        title.position = CGPoint(x: self.frame.width/2, y: self.frame.height*0.65)
        
        self.addChild(title)
        
        let text:SKLabelNode = SKLabelNode()
        text.fontName = "AvenirNext-UltraLight"
        text.fontSize = 60
        text.text = "Tap to play!"
        text.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        
        self.addChild(text)
        
        
        let car:SKSpriteNode = SKSpriteNode(imageNamed: "CarUp")
        car.position = CGPoint(x: self.frame.width/2, y: self.frame.height*0.25)
        car.scale(to: CGSize.zero)
        self.addChild(car)
        
        let appearCar = SKAction.scale(to: 4.0, duration: 1.0)
        let reduceCar = SKAction.scale(by: 0.8, duration: 0.5)
        
        let continuousScale = SKAction.repeatForever(SKAction.sequence([reduceCar, reduceCar.reversed()]))
        
        let animateCar = SKAction.sequence([appearCar, continuousScale])
        car.run(animateCar)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        let gameScene = GameScene(size: self.size)
        gameScene.scaleMode = .aspectFit
        
        let transition = SKTransition.reveal(with: .right, duration: 1.0)
        self.removeAllActions()
        self.removeAllChildren()
        self.view?.presentScene(gameScene, transition: transition)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
