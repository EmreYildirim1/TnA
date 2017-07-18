//
//  GameScene.swift
//  TnA
//
//  Created by Emre Yıldırım on 7/18/17.
//  Copyright © 2017 Emre Yildirim. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var player : Player!
    
    var center = CGFloat()
    
    var canMove = false, moveLeft = false
    
    override func didMove(to view: SKView) {
        initializeGame();
    }
    
    override func update(_ currentTime: TimeInterval) {
        managePlayer()
        player.position.x = clamp(value: player.position.x, lower: player.size.width / 2, upper: UIScreen.main.bounds.size.width * 2 - player.size.width / 2)
    }
    
    func initializeGame() {
        player = childNode(withName: "Player") as? Player!
        
        center = UIScreen.main.bounds.size.width
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            if location.x > center {
                moveLeft = false
            } else {
                moveLeft = true
                
            }
        }
        canMove = true
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        canMove = false
    }
    
    private func managePlayer() {
        if canMove {
            player.move(left: moveLeft)
        }
    }
}

func clamp<T: Comparable>(value: T, lower: T, upper: T) -> T {
    return min(max(value, lower), upper)
}

