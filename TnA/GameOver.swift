//
//  GameOver.swift
//  TnA
//
//  Created by Emre Yıldırım on 7/19/17.
//  Copyright © 2017 Emre Yildirim. All rights reserved.
//

import SpriteKit

class GameOver: SKScene {
    
    var restartButton: MSButtonNode!
    
    override func didMove(to view: SKView) {
        restartButton = childNode(withName: "restartButton") as! MSButtonNode
        restartButton.selectedHandler = {
            let skView = self.view as SKView!
            let scene = GameScene(fileNamed: "GameScene")
            scene?.scaleMode = .aspectFill
            skView?.presentScene(scene)
        }
    }
    
}
