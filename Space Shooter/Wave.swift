//
//  Wave.swift
//  Space Shooter
//
//  Created by Anya Kapoor on 2/9/21.
//  Copyright © 2021 Anya Kapoor. All rights reserved.
//

import SpriteKit

struct Wave: Codable {
    struct WaveEnemy: Codable {
        let position: Int
        let xOffest: CGFloat
        let moveStraight: Bool
    }
    let name: String
    let enemies: [WaveEnemy]
}

