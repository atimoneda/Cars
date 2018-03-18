//
//  GameOverScene.swift
//  Cars
//
//  Created by Arnau Timoneda Heredia on 22/1/18.
//  Copyright © 2018 Arnau Timoneda Heredia. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class GameOverScene: SKScene {
    
    var score:NSInteger = NSInteger()
    var playtAgainButton:SKSpriteNode = SKSpriteNode()
    var buttonText:SKLabelNode = SKLabelNode()
    
    var scores:[Score] = []
    
    override func didMove(to view: SKView) {
        self.paintTheScreen()

        // MARK: Alert controller fot player name
        let alertController : UIAlertController = UIAlertController(title: "Register Score", message: "Congratulations! Your score is: \(score). Type your name to register it!", preferredStyle: .alert)
        
        //Text field
        alertController.addTextField { (nombreTextField : UITextField!) -> Void in
            nombreTextField.placeholder = "name"
        }
        
        //Confirm Action
        let anAction : UIAlertAction = UIAlertAction(title: "Confirm", style: .default, handler: {
            (action) in
            if let name = (alertController.textFields![0] as UITextField).text {
                //if !name.isEmpty {
                    let _:Score = CoreDataManager.sharedInstance.addScrore(playerName: name, score: self.score as NSNumber)
                    self.scores = CoreDataManager.sharedInstance.getScores();
                    self.paintScoreTable()
                //}
            }
        })
        alertController.addAction(anAction)
        
        self.view?.window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    //Paint the layout of the screen
    func paintTheScreen(){
        self.backgroundColor = UIColor(red: 0.3, green: 0.7, blue: 0.3, alpha: 1)
        let title:SKLabelNode = SKLabelNode()
        
        title.fontName = "AvenirNext-Regular"
        title.fontSize = 120
        title.text = "Game Over"
        title.alpha = 1
        title.position = CGPoint(x: self.frame.width/2, y: self.frame.height*0.85)
        
        self.addChild(title)
        
        let scoreLabel:SKLabelNode = SKLabelNode()
        
        scoreLabel.fontName = "AvenirNext-Regular"
        scoreLabel.fontSize = 60
        scoreLabel.text = "Your score: \(score)"
        scoreLabel.alpha = 1
        scoreLabel.position = CGPoint(x: self.frame.width/2, y: self.frame.height*0.75)
        
        self.addChild(scoreLabel)
        
        playtAgainButton = SKSpriteNode(color: UIColor.red , size: CGSize(width: self.size.width*0.8, height: 100))
        playtAgainButton.position = CGPoint(x: (self.size.width)/2, y: 160)
        playtAgainButton.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        playtAgainButton.name = "button"
        
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
    
    func paintScoreTable(){
        let playerLabelTitle:SKLabelNode = SKLabelNode()
        playerLabelTitle.fontName = "AvenirNext-Regular"
        playerLabelTitle.fontSize = 30
        playerLabelTitle.text = "Player Name"
        playerLabelTitle.alpha = 1
        playerLabelTitle.position = CGPoint(x: self.frame.width/3, y: self.frame.height*0.65)
        self.addChild(playerLabelTitle)
        
        
        let scoreLabelTitle:SKLabelNode = SKLabelNode()
        scoreLabelTitle.fontName = "AvenirNext-Regular"
        scoreLabelTitle.fontSize = 30
        scoreLabelTitle.text = "Score"
        scoreLabelTitle.alpha = 1
        scoreLabelTitle.position = CGPoint(x: (self.frame.width/3)*2, y: self.frame.height*0.65)
        self.addChild(scoreLabelTitle)
        
        var index = 1;
        for score:Score in self.scores {
            let playerL:SKLabelNode = SKLabelNode()
            playerL.fontName = "AvenirNext-Regular"
            playerL.fontSize = 25
            playerL.text = "\(index)- \(score.playerName ?? "--")"
            playerL.alpha = 1
            let aux:CGFloat = 0.65 - (CGFloat(index) * 0.04)
            playerL.position = CGPoint(x: self.frame.width/3, y: self.frame.height*aux)
            self.addChild(playerL)
            
            
            let playerS:SKLabelNode = SKLabelNode()
            playerS.fontName = "AvenirNext-Regular"
            playerS.fontSize = 25
            playerS.text = "\(score.score)"
            playerS.alpha = 1
            playerS.position = CGPoint(x: (self.frame.width/3)*2, y: self.frame.height*aux)
            self.addChild(playerS)
            print(aux)
            
            index += 1
        }
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
