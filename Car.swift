//
//  Car.swift
//  Cars
//
//  Created by Arnau Timoneda Heredia on 8/6/17.
//  Copyright © 2017 Arnau Timoneda Heredia. All rights reserved.
//

import UIKit
import SpriteKit

class Car: NSObject {
    var node:SKSpriteNode
    var status:Status
    
    enum Status{
        case left
        case center
        case right
    }
    override init(){
        self.node = SKSpriteNode()
        self.status = .center
    }
    
    func turnLeft(){
        switch self.status {
        case .right:
            self.status = .center
        default:
            self.status = .left
        }
    }
    
    func turnRight(){
        switch self.status {
        case .left:
            self.status = .center
        default:
            self.status = .right
        }
    }
}
