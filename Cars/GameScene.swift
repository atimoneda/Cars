//
//  GameScene.swift
//  Cars
//
//  Created by Arnau Timoneda Heredia on 30/5/17.
//  Copyright © 2017 Arnau Timoneda Heredia. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //var road = SKSpriteNode()
    var car:Car!
    
    //X central point position of road tracks.
    let POSITION_TRACK_1: CGFloat = 0.275 //103,125
    let POSITION_TRACK_2: CGFloat = 0.5 //187,5
    let POSITION_TRACK_3: CGFloat = 0.725 //271,875
    
    
    //
    let POSITION_MOVE:CGFloat = 0.225
    
    
    var textureEnemyUp = SKTexture()
    var textureEnemyDown = SKTexture()
    
    var blueTextureEnemyUp = SKTexture()
    var blueTextureEnemyDown = SKTexture()
    
    var greenTextureEnemyUp = SKTexture()
    var greenTextureEnemyDown = SKTexture()
    
    var yellowTextureEnemyUp = SKTexture()
    var yellowTextureEnemyDown = SKTexture()
    
    
    let categoryCar: UInt32 = 1 << 0
    let categoryEnemy: UInt32 = 1 << 1
    
    
    
    var xTrackPositions: [UInt32:CGFloat] = [:]
    var enemyColorTextures: [UInt32:String] = [:]
    
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor.clear
        
        self.physicsWorld.contactDelegate = self
        self.initializeApp()
        
        print("mide:: : \((self.view?.frame.width)!)")
        //Añadir la carretera
        let textureRoad = SKTexture(imageNamed: "Road")
        textureRoad.filteringMode = SKTextureFilteringMode.nearest
        
        let roadMovement = SKAction.moveBy(x: 0.0, y: -textureRoad.size().height, duration: 3)
        let resetRoad = SKAction.moveBy(x: 0.0, y: textureRoad.size().height, duration: 0.0)
        let continuousRoadMovement = SKAction.repeatForever(SKAction.sequence([roadMovement, resetRoad]))
        
        for i:Int in 0 ..< Int(2 + self.frame.size.height/textureRoad.size().height) {
            var road = SKSpriteNode(texture: textureRoad)
            road = SKSpriteNode(texture: textureRoad)
            road.anchorPoint = CGPoint.zero
            road.position = CGPoint(x: 0, y: i*Int(road.size.height))
            road.size.width = self.size.width
            road.run(continuousRoadMovement)
            self.addChild(road)
        }
        
        //Añadir el coche
        let textureCarUp = SKTexture(imageNamed: "CarUp")
        textureCarUp.filteringMode = SKTextureFilteringMode.nearest
        
        let textureCarDown = SKTexture(imageNamed: "CarDown")
        textureCarDown.filteringMode = SKTextureFilteringMode.nearest
        
        /* to refactor textures */
        blueTextureEnemyUp = SKTexture(imageNamed: "BlueEnemyUp")
        blueTextureEnemyUp.filteringMode = SKTextureFilteringMode.nearest
        
        blueTextureEnemyDown = SKTexture(imageNamed: "BlueEnemyDown")
        blueTextureEnemyDown.filteringMode = SKTextureFilteringMode.nearest
        
        greenTextureEnemyUp = SKTexture(imageNamed: "GreenEnemyUp")
        greenTextureEnemyUp.filteringMode = SKTextureFilteringMode.nearest
        
        greenTextureEnemyDown = SKTexture(imageNamed: "GreenEnemyDown")
        greenTextureEnemyDown.filteringMode = SKTextureFilteringMode.nearest
        
        yellowTextureEnemyUp = SKTexture(imageNamed: "YellowEnemyUp")
        yellowTextureEnemyUp.filteringMode = SKTextureFilteringMode.nearest
        
        yellowTextureEnemyDown = SKTexture(imageNamed: "YellowEnemyDown")
        yellowTextureEnemyDown.filteringMode = SKTextureFilteringMode.nearest
        
        
        /* end */
        
        let carMovement = SKAction.animate(with: [textureCarDown, textureCarUp],
                        timePerFrame: 0.30)
        let driving = SKAction.repeatForever(carMovement)
        
        //Unexpected found nil while unwraping an optional value
        car = Car()
        car.node = SKSpriteNode(texture: textureCarUp)
        
        car.node.position = CGPoint(x: self.frame.size.width/2,
                               y: 100)
        
        
        //Colisiones
        car.node.physicsBody = SKPhysicsBody(rectangleOf: car.node.size)
        car.node.physicsBody?.usesPreciseCollisionDetection = true
        car.node.physicsBody?.isDynamic = false
        car.node.physicsBody?.categoryBitMask = categoryCar
        car.node.physicsBody?.collisionBitMask = categoryEnemy
        car.node.physicsBody?.contactTestBitMask = categoryEnemy
        
        car.node.run(driving)
        
        self.addChild(car.node)
        //FIN COCHE
        
        //Enemigos
        textureEnemyUp = SKTexture(imageNamed: "enemyUp")
        textureEnemyUp.filteringMode = SKTextureFilteringMode.nearest
        
        textureEnemyDown = SKTexture(imageNamed: "enemyDown")
        textureEnemyDown.filteringMode = SKTextureFilteringMode.nearest
        
        
        
        let createEnemy = SKAction.run({ () in self.manageEnemies()})
        let delayEnemies = SKAction.wait(forDuration: 1)//var level
        let createNextEnemy = SKAction.sequence([createEnemy, delayEnemies])
        let continuousEnemies = SKAction.repeatForever(createNextEnemy)
        
        self.run(continuousEnemies)
        
        
        print("la pantalla mide \(self.frame.size)")
    }
    
    func manageEnemies(){
        let textures = self.getRandomEnemyTexture()
        
        let enemyMovement = SKAction.animate(with:textures, timePerFrame: 0.30)
        let drivingEnemy = SKAction.repeatForever(enemyMovement)
        
        let enemy = SKSpriteNode(texture: textures[0])
        //let index = xTrackPositions[arc4random_uniform(3) + 1]
        
        enemy.position = CGPoint(x: xTrackPositions[arc4random_uniform(3) + 1]! , y: self.frame.height + enemy.size.height)
        enemy.run(drivingEnemy)
        
        //Colisions
        enemy.physicsBody = SKPhysicsBody(rectangleOf:enemy.size)
        enemy.physicsBody?.usesPreciseCollisionDetection = true
        enemy.physicsBody?.isDynamic = false
        enemy.physicsBody?.categoryBitMask = categoryEnemy
        enemy.physicsBody?.collisionBitMask = categoryCar
        enemy.physicsBody?.contactTestBitMask = categoryCar
        
        let enemyRide = SKAction.move(to: CGPoint(x: enemy.position.x, y: -enemy.frame.height) , duration: 4)//var level
        let removeEnemy = SKAction.removeFromParent()
        
        let enemyCycle = SKAction.sequence([enemyRide, removeEnemy])
        
        enemy.run(enemyCycle)
        self.addChild(enemy)

    }

    
    func moveCarTo(position:Car.Status){
        var pos = POSITION_TRACK_2
        switch position {
        case .left:
            pos = POSITION_TRACK_1
        case .center:
            pos = POSITION_TRACK_2
        case .right:
            pos = POSITION_TRACK_3
        }
        let carTurn = SKAction.move(to: CGPoint(x:(self.frame.size.width) * pos, y: 100), duration: 0.5)
        //let carTurn = SKAction.moveBy(x: (self.frame.size.width) * pos, y: 0, duration: 0.5)
        self.car.node.run(carTurn)
    }
    
    func initializeApp(){
        xTrackPositions[1] = POSITION_TRACK_1 * self.frame.size.width
        xTrackPositions[2] = POSITION_TRACK_2 * self.frame.size.width
        xTrackPositions[3] = POSITION_TRACK_3 * self.frame.size.width
        print("lelele \(xTrackPositions[1])")
        
        enemyColorTextures[1] = "Red"
        enemyColorTextures[2] = "Blue"
        enemyColorTextures[3] = "Yellow"
        enemyColorTextures[4] = "Green"
        
    }
    
    func getRandomEnemyTexture() -> [SKTexture] {
        var result:[SKTexture]
        let color = enemyColorTextures[arc4random_uniform(4) + 1]!
        print("enemigo de color \(color) :::::: ")
        switch color {
        case "Yellow":
            result = [yellowTextureEnemyUp, yellowTextureEnemyDown]
        case "Blue":
            result = [blueTextureEnemyUp, blueTextureEnemyDown]
        case "Red":
            result = [textureEnemyUp, textureEnemyDown]
        case "Green":
            result = [greenTextureEnemyUp, greenTextureEnemyDown]
        default:
            result = [textureEnemyUp, textureEnemyDown]
        }
        return result
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        print("Patapam!")
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("he tocado en: \(touches.first!.location(in: self.view))")
        if touches.first!.location(in: self.view).x < (self.view?.frame.width)!/2 {
            self.car.turnLeft()
            
        } else {
            self.car.turnRight()
            //self.moveCarTo(position: POSITION_MOVE)
        }
        self.moveCarTo(position: self.car.status)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }

}
