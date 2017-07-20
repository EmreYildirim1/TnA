//
//  GameScene.swift
//  TnA
//
//  Created by Emre Yıldırım on 7/18/17.
//  Copyright © 2017 Emre Yildirim. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate

{
    let fixedDelta: CGFloat = 1.0 / 60.0 // 60 FPS
    
    var enemySpawnTimer: CGFloat = 0
    
    var bombSpawnTimer: CGFloat = 0
    
    var tacoSpawnTimer: CGFloat = 0
    
    /* it gives enemy speed (velocity) */
    let enemySpeed: CGFloat = 1000
    
    /* it gives bomb speed (velocity)*/
    let bombSpeed: CGFloat = 1000
    
    /* it gives taco speed (velocity) */
    let tacoSpeed: CGFloat = 1000
    
    var player : Player!
    
    var bomb : SKSpriteNode!
    
    var enemy : SKSpriteNode!
    
    var taco : SKSpriteNode!
    
    var scoreLabel : SKLabelNode!
    
    var score : Int = 0 {
        didSet {
            scoreLabel.text = String(score)
        }
    }
    
    var center = CGFloat()
    
    var canMove = false, moveLeft = false
    
    var enemies: [SKSpriteNode] = []
    
    var bombs: [SKSpriteNode] = []
    
    var tacos: [SKSpriteNode] = []
    
    override func didMove(to view: SKView) {
        self.view?.showsPhysics = false
        initializeGame();
    }
    
    override func update(_ currentTime: TimeInterval) {
        managePlayer()
        player.position.x = clamp(value: player.position.x, lower: player.size.width / 2, upper: UIScreen.main.bounds.size.width * 2 - player.size.width / 2)
        
        if enemySpawnTimer > 2.5 {
            spawnEnemy()
            enemySpawnTimer = 0        
        }
        
        if bombSpawnTimer > 0.5  {
            spawnBombs()
            bombSpawnTimer = 0
        }
        
        if tacoSpawnTimer > 1.5 {
            spawnTacos()
            tacoSpawnTimer = 0
        }
        
        for node in bombs {
            node.position.y -= bombSpeed * fixedDelta
            if node.position.y < -UIScreen.main.bounds.height * 2 {
                node.removeFromParent()
                bombs.remove(at: bombs.index(of: node)!)
            }
        }
        
        enemySpawnTimer += fixedDelta
        
        for node in enemies {
            node.position.y -= enemySpeed * fixedDelta
            if node.position.y < -UIScreen.main.bounds.size.height * 2 {
                node.removeFromParent()
                enemies.remove(at: enemies.index(of: node)!)
            }
        }
        
        bombSpawnTimer += fixedDelta
       
        for node in tacos {
            node.position.y -= tacoSpeed * fixedDelta
            if node.position.y < -UIScreen.main.bounds.size.height * 2 {
                node.removeFromParent()
                tacos.remove(at: tacos.index(of: node)!)
            }
        }
        
        tacoSpawnTimer += fixedDelta
        
    }

    func initializeGame() {
        physicsWorld.contactDelegate = self
        player = childNode(withName: "Player") as? Player!
        enemy = childNode(withName: "enemy") as! SKSpriteNode
        center = UIScreen.main.bounds.size.width
        bomb = childNode(withName: "bomb") as! SKSpriteNode
        taco = childNode(withName: "taco") as! SKSpriteNode
        scoreLabel = childNode(withName: "scoreLabel") as! SKLabelNode
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let nodeA = contact.bodyA.node
        let nodeB = contact.bodyB.node
        
        if nodeA?.name == "enemy" || nodeB?.name == "enemy" {
            score += 2
            if nodeA?.name == "enemy" {
                enemies.remove(at: enemies.index(of: nodeA as! SKSpriteNode)!)
                nodeA?.removeFromParent()
            } else if nodeB?.name == "enemy" {
                enemies.remove(at: enemies.index(of: nodeB as! SKSpriteNode)!)
                nodeB?.removeFromParent()
            }
        } else if nodeA?.name == "taco" || nodeB?.name == "taco" {
            score += 1
            if nodeA?.name == "taco" {
                tacos.remove(at: tacos.index(of: nodeA as! SKSpriteNode)!)
                nodeA?.removeFromParent()
            } else if nodeB?.name == "taco" {
                tacos.remove(at: tacos.index(of: nodeB as! SKSpriteNode)!)
                nodeB?.removeFromParent()
            }
        } else if nodeA?.name == "bomb" || nodeB?.name == "bomb" {
            if nodeA?.name == "bomb" {
                bombs.remove(at: bombs.index(of: nodeA as! SKSpriteNode)!)
                nodeA?.removeFromParent()
            } else if nodeB?.name == "bomb" {
                bombs.remove(at: bombs.index(of: nodeB as! SKSpriteNode)!)
                nodeB?.removeFromParent()
            }
            let skView = self.view as SKView!
            let scene = GameOver(fileNamed: "GameOver")
            scene?.scaleMode = .aspectFill
            skView?.presentScene(scene)
        }
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
    
    func managePlayer() {
        if canMove {
            player.move(left: moveLeft)
        }
    }
    
    func spawnEnemy() {
        let x = CGFloat(arc4random_uniform(UInt32(center * 2 - enemy.size.width / 2))) + enemy.size.width / 2
        let enemyCopy = enemy.copy() as! SKSpriteNode
        enemyCopy.position.x = x
        enemies.append(enemyCopy)
        addChild(enemyCopy)
    }
    
    func spawnBombs() {
        let x = CGFloat(arc4random_uniform(UInt32(center * 2 - enemy.size.width / 2))) + enemy.size.width / 2
        let bombCopy = bomb.copy() as! SKSpriteNode
        bombCopy.position.x = x
        bombs.append(bombCopy)
        addChild(bombCopy)
    }
    
    func spawnTacos() {
        let x = CGFloat(arc4random_uniform(UInt32(center * 2 - enemy.size.width / 2))) + enemy.size.width / 2
        let tacoCopy = taco.copy() as! SKSpriteNode
        tacoCopy.position.x = x
        tacos.append(tacoCopy)
        addChild(tacoCopy)
    }
}

func clamp<T: Comparable>(value: T, lower: T, upper: T) -> T {
    return min(max(value, lower), upper)
}

