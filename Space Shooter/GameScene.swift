//
//  GameScene.swift
//  Space Shooter
//
//  Created by Anya Kapoor on 1/26/21.
//  Copyright © 2021 Anya Kapoor. All rights reserved.
//

import SpriteKit
import GameplayKit
enum CollisionType: UInt32 {
    case player = 1
    case playerWeapon = 2
    case enemy = 4
    case enemyWeapon = 8
}
class GameScene: SKScene {
    
    let player = SKSpriteNode(imageNamed: "spaceship")
    let waves = Bundle.main.decode([Wave].self, from: "waves.json")
    let enemyTypes = Bundle.main.decode([EnemyType].self, from: "enemy-types.json")
    var waveNumber = 0
    var isPlayerAlive = true
    let positions = Array(stride(from: -320, to: 320, by: 80))
    var levelNumber = 0
   
    override func didMove(to view: SKView) {
        if let particles = SKEmitterNode(fileNamed: "Stars"){
            particles.position = CGPoint(x: 1080, y: 0)
         //   particles.advanceSimulationTime(<#T##sec: TimeInterval##TimeInterval#>)
            addChild(particles)
        }
        player.name = "player"
        player.position.x = frame.minX + 75
        player.zPosition = 1
        addChild(player)
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.texture!.size())
        player.physicsBody?.categoryBitMask = CollisionType.player.rawValue
        player.physicsBody?.collisionBitMask = CollisionType.enemy.rawValue|CollisionType.enemyWeapon.rawValue
        player.physicsBody?.contactTestBitMask = CollisionType.enemy.rawValue|CollisionType.enemyWeapon.rawValue
        player.physicsBody?.isDynamic = false
  
        
    
        setupLabels()
    }
    func setupLabels(){
        let scoreTextLabel: SKLabelNode = SKLabelNode(text: "score")
        scoreTextLabel.position = CGPoint(x: 14.0, y: frame.size.height - 200.0)
        scoreTextLabel.horizontalAlignmentMode = .left
        scoreTextLabel.fontName = "Courier-Bold"
        scoreTextLabel.fontSize = 14.0
        scoreTextLabel.zPosition = 20
        addChild(scoreTextLabel)
    }
    override func update(_ currentTime: TimeInterval){
        let activeEnemies = children.compactMap{$0 as? EnemyNode}
        if activeEnemies.isEmpty {
            createWave()
        }
    }
    
    func createWave() {
        guard isPlayerAlive else { return }

        if waveNumber == waves.count {
            levelNumber += 1
            waveNumber = 0
        }

        let currentWave = waves[waveNumber]
        waveNumber += 1

        let maximumEnemyType = min(enemyTypes.count, levelNumber + 1)
        let enemyType = Int.random(in: 0..<maximumEnemyType)

        let enemyOffsetX: CGFloat = 100
        let enemyStartX = 600

        if currentWave.enemies.isEmpty {
            for (index, position) in positions.shuffled().enumerated() {
                let enemy = EnemyNode(type: enemyTypes[enemyType], startPosition: CGPoint(x: enemyStartX, y: position), xOffset: enemyOffsetX * CGFloat(index * 3), moveStraight: true)
                addChild(enemy)
            }
        }
        else {
            for enemy in currentWave.enemies {
//                let node = EnemyNode(type: enemyTypes[enemyType], startPosition: CGPoint(x: enemyStartX, y: positions[enemy.position]), xOffset: enemyOffsetX * enemy.xOffset, moveStraight: enemy.moveStraight)
//                addChild(node)
            }
        }
    }
}
