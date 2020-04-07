//
//  Player.swift
//  p3OC
//
//  Created by Merouane Bellaha on 01/02/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import Foundation

final class Player {
    
    // MARK: - Properties
    
    let name: String
    let numberOfCharacter = 3
    var characterTeam = [Character]()
    private static var characterNameList: [String] = []
    var state: State = .inGame
    
    enum State {
        case inGame, out
    }
    
    // MARK: - Init
    
    init(name: String) {
        self.name = name
        setCharacterTeam()
    }
    
    // MARK: - Methods
    
    /// set an unique name for the Character instancied in setCharacterTeam() by checking if the characterName is not already in characterNameList[] and is not an empty String, if not add it to characterNameList[] and return characterName.
    private func setUniqueCharacterName() -> String {
        print("\n🖊️ Saisissez le nom de votre héro:\n")
        while true {
            if let characterName = readLine()?.trimWhiteSpaces {
                guard !characterName.isEmpty && !Player.characterNameList.contains(characterName) else {
                    print(text.noName)
                    continue
                }
                Player.characterNameList.append(characterName)
                print("\nVotre héro s'appelle \(characterName).\n")
                return characterName
            }
        }
    }
    
    /// set for each init() of a Player, a team[] of as many Character instance as numberOfCharacter value by selecting them from text.charactersList, and then displayCharacterTeam when completed.
    private func setCharacterTeam() {
        print("▶️ \(name), sélectionnez vos héros dans la liste ci dessus en saisissant le chiffre associé:\n ")
        for i in 0..<numberOfCharacter {
            print("⏳ Héro \(i+1)/\(numberOfCharacter)")
            print(text.charactersList)
            var setNewCharacter: Character? = nil
            while setNewCharacter == nil {
                if let playerSelect = readLine()?.trimWhiteSpaces {
                    switch playerSelect {
                    case "1" :
                        setNewCharacter = Character(weapon: Weapon(name: "Hache", damage: 30, heal: 0), life: 40, type: "🗡 Guerrier", name: setUniqueCharacterName())
                    case "2" :
                        setNewCharacter = Character(weapon: Weapon(name: "Orbe", damage: 30, heal: 10), life: 40, type: "🔮 Mage", name: setUniqueCharacterName())
                    case "3" :
                        setNewCharacter = Character(weapon: Weapon(name: "Dagues", damage: 30, heal: 10), life: 40, type: "🔪 Voleur", name: setUniqueCharacterName())
                    case "4" :
                        setNewCharacter = Character(weapon: Weapon(name: "Arc", damage: 30, heal: 10), life: 30, type: "🏹 Chasseur", name: setUniqueCharacterName())
                    case "5" :
                        setNewCharacter = Character(weapon: Weapon(name: "Baguette", damage: 30, heal: 30), life: 20, type: "🔅 Prêtre", name: setUniqueCharacterName())
                    default:
                        print(text.selectWithNumber)
                    }
                }
            }
            if let chosenCharacter = setNewCharacter {
                characterTeam.append(chosenCharacter)
            }
        }
        print("\(name) votre équipe se compose de:\n")
        displayCharacterTeam()
        print("\n\(text.breakingLine)")
    }
    
    /// display a numbered list of name and description for each Character in team[].
    private func displayCharacterTeam() {
        var number = 0
        for character in characterTeam {
            number += 1
            print("   \(number) - \(character.description)") // \(character.name)
        }
    }
    
    /// display a numbered list of name and description for each Character in activePlayer.team[] followed by each Character in opponant.team[].
    private func displayAllCharacterTeam(incl opponant: [Player]) {
        print("\nVous pouvez soigner en sélectionnant l'un de vos héros:\n")
        displayCharacterTeam()
        print("")
        print("ou attaquer en sélectionnant un héro adverse:\n")
        var number = numberOfCharacter
        for player in opponant {
            print("Equipe de \(player.name):")
            for character in player.characterTeam {
                number += 1
                print("   \(number) - \(character.description)")
            }
        }
    }
    
    /// displayCharacterTeam list, playerSelect his activeCharacter from it, if activeCharacter exists in team[] and his life is not 0 then return the activeCharacter.
    func selectActiveCharacter() -> Character {
        print("\n▶️ \(name), sélectionnez le héro avec lequel vous souhaitez faire une action dans la liste\n ci-dessous en saisissant le chiffre associé:\n ")
        displayCharacterTeam()
        while true {
            if let playerSelect = readLine()?.trimWhiteSpaces {
                guard let activeCharacterSelection = Int(playerSelect) else {
                    print("\(text.selectWithNumber)")
                    continue
                }
                guard activeCharacterSelection <= numberOfCharacter && !playerSelect.isEmpty && activeCharacterSelection != 0 else {
                    print("\(text.selectWithNumber)")
                    continue
                }
                guard characterTeam[activeCharacterSelection-1].life > 0 else {
                    print("\(text.heroIsDead)")
                    continue
                }
                return characterTeam[activeCharacterSelection-1]
            }
        }
    }
    /// displayCharacterTeam list, playerSelect his targetCharacter from it, control if it's a valide selection then if  it's an ally or an enemy, if it's an ally return it with .wiilBeHealed state, if it's an enemy return it with .willBeAttacked state.
    func selectTargetCharacter(incl opponant: [Player]) -> Character {
        print("\n▶️ \(name), sélectionnez le héro que vous souhaitez cibler dans la liste ci-dessous en saisissant le chiffre associé: ")
        displayAllCharacterTeam(incl: opponant)
        
        while true {
            if let playerSelect = readLine()?.trimWhiteSpaces {
                guard let targetSelection = Int(playerSelect) else {
                    print("\(text.selectWithNumber)")
                    continue
                }
                guard targetSelection <= (numberOfCharacter + opponant.count*numberOfCharacter) && !playerSelect.isEmpty && targetSelection != 0 else {
                    print("\(text.selectWithNumber)")
                    continue
                }
                guard targetSelection > numberOfCharacter else {
                    guard characterTeam[targetSelection-1].life > 0 else {
                        print("\(text.heroIsDead)")
                        continue
                    }
                    characterTeam[targetSelection-1].state = .willBeHealed
                    return characterTeam[targetSelection-1]
                }
                let targetOpponantIndex = ((targetSelection-1)/numberOfCharacter)-1
                var characterRange = 1
                for _ in 0...targetOpponantIndex {
                    characterRange += numberOfCharacter
                }
                guard opponant[targetOpponantIndex].characterTeam[targetSelection - characterRange].life > 0 else {
                    print("\(text.heroIsDead)")
                    continue
                }
                opponant[targetOpponantIndex].characterTeam[targetSelection - characterRange].state = .willBeAttacked
                return opponant[targetOpponantIndex].characterTeam[targetSelection - characterRange]
            }
        }
    }
    
    /// remove all element from characterNameList.
    static func clearCharacterNameList() {
        characterNameList.removeAll()
    }
}

