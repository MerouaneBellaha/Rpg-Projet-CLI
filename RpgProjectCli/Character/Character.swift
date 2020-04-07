//
//  Character.swift
//  p3OC
//
//  Created by Merouane Bellaha on 01/02/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import Foundation

final class Character {
    
    // MARK: - Properties
    
    let name: String
    var weapon: Weapon
    var life: Int
    let maxLife: Int
    let type: String
    var description: String {
        if life > 0 {
            return "\(name.capitalized), le \(type) a \(life) point(s) de vie. Son arme: \(weapon.name)(Dégâts: \(weapon.damage),Soin: \(weapon.heal))."
        } else {
            return "\(name.capitalized) est mort, RIP. Jadis il avait \(maxLife) point(s) de vie. Mais ce qui nous manquera, c'est son arme: \(weapon.name).💸💸"
        }
    }
    var state: State = .notATarget
    
    enum State {
        case notATarget, willBeHealed, willBeAttacked
    }
    
    // MARK: - Init
    
    init(weapon: Weapon, life: Int, type: String, name: String) {
        self.weapon = weapon
        self.life = life
        self.type = type
        self.maxLife = life
        self.name = name
    }
    
    // MARK: - Methods
    
    /// heal the targetCharacter by adding the activeCharacter.weapon.heal value to targetCharacter.life making sure it stays equal or under targetCharacter.maxLife.
    func heal(_ targetCharacter: Character) {
        targetCharacter.life += weapon.heal
        if targetCharacter.life > targetCharacter.maxLife {
            let overHeal = targetCharacter.life - targetCharacter.maxLife
            print("\n❗ Attention, vous avez overheal \(targetCharacter.name) de : \(overHeal).")
            targetCharacter.life = targetCharacter.maxLife
        } else {
            print("\n❗ \(targetCharacter.name) a été soigné de \(weapon.heal) points de vie, il a maintenant \(targetCharacter.life) points de vie.")
        }
    }
    
    /// attack the targetCharacter by removing the activeCharacter.weapon.damage value to targetCharacter.life making sure it never goes under 0.
    func attack(_ targetCharacter: Character) {
        targetCharacter.life -= weapon.damage
        if targetCharacter.life <= 0 {
            targetCharacter.life = 0
            print("\n❗ \(targetCharacter.name) a subi \(weapon.damage) dégâts et meurt de ses blessures !")
        } else {
            print("\n❗ \(targetCharacter.name) a subi \(weapon.damage) dégâts, il lui reste \(targetCharacter.life) points de vie.")
        }
    }
}
