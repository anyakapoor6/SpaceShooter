//
//  EnemyType.swift
//  Space Shooter
//
//  Created by Anya Kapoor on 2/9/21.
//  Copyright © 2021 Anya Kapoor. All rights reserved.
//

import SpriteKit

struct EnemyType: Codable {
    let name: String
    let shields: Int
    let speed: CGFloat
    let powerUpChance: Int
}
