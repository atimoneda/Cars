//
//  GameOverScene.swift
//  Cars
//
//  Created by Arnau Timoneda Heredia on 22/1/18.
//  Copyright © 2018 Arnau Timoneda Heredia. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    
    var score:NSInteger = NSInteger()
    var playtAgainButton:SKSpriteNode = SKSpriteNode()
    var buttonText:SKLabelNode = SKLabelNode()
    
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor(red: 0.3, green: 0.7, blue: 0.3, alpha: 1)
        
        let title:SKLabelNode = SKLabelNode()
        
        title.fontName = "AvenirNext-Regular"
        title.fontSize = 120
        title.text = "Game Over"
        title.alpha = 1
        title.position = CGPoint(x: self.frame.width/2, y: self.frame.height*0.80)
        
        self.addChild(title)
        
        let scoreLabel:SKLabelNode = SKLabelNode()
        //score = 1986
        
        scoreLabel.fontName = "AvenirNext-Regular"
        scoreLabel.fontSize = 60
        scoreLabel.text = "Your score: \(score)"
        scoreLabel.alpha = 1
        scoreLabel.position = CGPoint(x: self.frame.width/2, y: self.frame.height*0.60)
        
        self.addChild(scoreLabel)
        
        playtAgainButton = SKSpriteNode(color: UIColor.red , size: CGSize(width: self.size.width*0.8, height: 100))
        playtAgainButton.position = CGPoint(x: (self.size.width)/2, y: 160)
        playtAgainButton.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        playtAgainButton.name = "button"
        
        //playtAgainButton.isUserInteractionEnabled = true
        
        self.addChild(playtAgainButton)
        
        
        buttonText.fontName = "AvenirNext-Bold"
        buttonText.fontSize = 60
        buttonText.fontColor = UIColor.black
        buttonText.text = "Play Again"
        buttonText.alpha = 1
        buttonText.name = "button"
        buttonText.position = CGPoint(x: playtAgainButton.frame.midX, y: playtAgainButton.frame.midY-(playtAgainButton.frame.height*0.20))
        
        self.addChild(buttonText)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            let positionInScene = touch.location(in:self)
            let touchedNode = self.atPoint(positionInScene)
            if let name = touchedNode.name
            {
                if name == "button"
                {
                    let buttonPressed = SKAction.scale(to: 0.98, duration: 0.1)
                    
                    playtAgainButton.run(buttonPressed)
                    buttonText.run(buttonPressed)
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let buttonUnpressed = SKAction.scale(to: 1, duration: 0.1)
        playtAgainButton.run(buttonUnpressed)
        buttonText.run(buttonUnpressed)
        if let touch = touches.first{
            let positionInScene = touch.location(in:self)
            let touchedNode = self.atPoint(positionInScene)
            if let name = touchedNode.name
            {
                if(name == "button") {
                    let newGameScene = GameScene(size:self.size)
                    newGameScene.scaleMode = scaleMode
                    newGameScene.score = self.score
                    
                    let transition = SKTransition.fade(withDuration: 1.0)
                    view?.presentScene(newGameScene, transition:transition)
                }
            }
        }
    }
    
}
