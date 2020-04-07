//
//  Weapon.swift
//  p3OC
//
//  Created by Merouane Bellaha on 01/02/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import Foundation

struct Weapon {
    
    // MARK: - Properties
    
    let name: String
    let damage: Int
    let heal: Int
    
    // MARK: - Init
    
    init(name: String, damage: Int, heal: Int) {
        self.name = name
        self.damage = damage
        self.heal = heal
    }
}
