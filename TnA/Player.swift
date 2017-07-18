//
//  Player.swift
//  TnA
//
//  Created by Emre Yıldırım on 7/18/17.
//  Copyright © 2017 Emre Yildirim. All rights reserved.
//

import SpriteKit

class Player : SKSpriteNode {
    
    func move(left: Bool) {
        if left {
            position.x -= 20 // 15
        } else {
            position.x += 20 // 15
            
        }
    }
}
