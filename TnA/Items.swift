//
//  Items.swift
//  TnA
//
//  Created by Emre Yıldırım on 7/18/17.
//  Copyright © 2017 Emre Yildirim. All rights reserved.
//

import SpriteKit

class Items {
    
    func spawnItems() -> SKSpriteNode {
        
        let item: SKSpriteNode!
    
        
    return SKSpriteNode()
   
    }
    
    func randomNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random_uniform(UInt32(secondNum))) + firstNum
    }
}
