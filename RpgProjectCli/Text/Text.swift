//
//  text.swift
//  p3OC
//
//  Created by Merouane Bellaha on 01/02/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import Foundation

struct text {
    static let welcome = """
\n===============================
👋 Bienvenue !
  Chaque joueur choisira à tour de rôle son nom et son équipe de Héros !
  Ensuite, le hasard décidera du joueur qui prendra la main.
  Et enfin, place au combat ⚔️ !
  La rumeur dit que le légendaire X a caché son trésor dans le coin,
  heureux seront ceux qui auront la chance de le trouver !
🏁 C'est parti !
===============================
"""
    
    static let sameName = "\n❌ Vous n'avez pas honte de copier? Saisissez un nom qui n'a pas dejà été selectionné. ❌\n"
    
    static let noName = "❌ Le nom que vous avez saisi n'est pas valide, soit il est vide soit il est déjà utilisé. ❌\n"
    
    static let charactersList = """
===============================
  1 - 🗡 Guerrier : Un comnbattant aux dégâts impressionant, mais ne comptez par lui pour soigner !
  2 - 🔮 Mage : Un sorcier aux pouvoirs gigantesques, mais ne comptez par lui pour soigner !
  3 - 🔪 Voleur : Un combattant polyvalent dont les dégâts comme les soins vous seront utiles !
  4 - 🏹 Chasseur : Un combattant polyvalent dont les dégâts comme les soins vous seront utiles !
  5 - 🔅 Prêtre :  Un guérisseur aux pouvoirs gigantesques, mais ne comptez par lui pour attaquer !
===============================\n
"""
    
    static let selectWithNumber = "\n❌ Sélectionnez en saisissant le chiffre associé. ❌\n"
    static let heroIsDead = "\n❌ Ce héro est mort, essayez plutôt avec un de ceux à qui il reste de la vie...🙄 ❌"
    
    static let summary = """
===============================
  Ce n'était pas glorieux pour tout le monde...
  Petit tour d'horizons de nos joueurs et leurs héros:
"""
    
    static let wannaPlayAgain = """
\n🔂 Voulez vous rejouer ?
  1 - Oui
  2 - Non\n
"""
    
    static let seeYouSoon = "\n👋 Adieu, on se revoit bientôt !\n"
    
    static let draw = """
❓ Place au hasard !
  Nous mélangeons les joueurs, pas d'inquiétude: aucune douleur à prévoir.
  ⏳ ⏳ ⏳
  Les jeux sont faits, l'ordre de jeu est maintennt le suivant:\n
"""
    
    static let chestAppears = """
  🎁 Tu as trouvé le trésor du légendaire X.
    Découvre ce qu'il se cache à l'intérieur...
    ⏳ ⏳ ⏳
  """
    
    static let breakingLine = "==============================="
}

