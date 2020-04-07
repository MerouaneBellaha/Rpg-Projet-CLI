//
//  Game.swift
//  p3OC
//
//  Created by Merouane Bellaha on 01/02/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import Foundation

final class Game {
    
    // MARK: - Properties
    
    private let numberOfPlayer = 2
    private var playerList = [Player]()
    private var playerNameList: [String] = []
    private var randomNumber: Int {
        return Int.random(in: 0..<100)
    }
    
    // MARK: - Methods
    
    /// set an unique name for the Player instancied in setPlayers() by checking if the playerName is not already in playerNameList[] and is not an empty String, if not add it to playerNameList[] and return PlayerName.
    private func setUniquePlayerName() -> String {
        while true {
            if let playerName = readLine()?.trimWhiteSpaces {
                guard !playerName.isEmpty && !playerNameList.contains(playerName) else {
                    print(text.noName)
                    continue
                }
                playerNameList.append(playerName)
                print("\n👋 Bienvenue \(playerName) !\n")
                return playerName
            }
        }
    }
    
    /// shuffle Player in playerList[] and print the new Player order.
    private func shufflePlayerList() {
        print("\(text.draw)")
        var positionCount = 0
        playerList.shuffle()
        for player in playerList {
            positionCount += 1
            print("  \(positionCount) - \(player.name). ")
        }
        print("\(text.breakingLine)")
    }
    
    /// set in playerList[] as many Player as numberOfPlayer value, then shufflePlayerList().
    private func setPlayers() {
        for i in 0..<numberOfPlayer {
            print("\n🖊️ Saisissez votre nom joueur \(i+1):\n")
            playerList.append(Player(name: setUniquePlayerName()))
        }
        shufflePlayerList()
    }
    
    /// update, for each Player in opponant[], his .State to .out if all his Character in his team[] have their life equal to 0, then return the number of Player.out.
    private func numberOfOutPlayer(in opponant: [Player]) -> Int {
        var deadCharactersCount: Int
        var nbrOfOutsCount = 0
        for player in opponant {
            deadCharactersCount = 0
            for characters in player.characterTeam where characters.life == 0 {
                deadCharactersCount += 1
            }
            if deadCharactersCount == player.numberOfCharacter {
                player.state = .out
                nbrOfOutsCount += 1
            }
        }
        return nbrOfOutsCount
    }
           

    
    /// activeCharacter have 40 % chance to find a chest( if he doesn't -> early return), in this case activeCharacter have 50% chance to switch his .weapon for a bad one, or 50%% chance to switch his .weapon for a better one which be different depending of his .type.
    private func isThereAnyChest(for activeCharacter: Character) {
        guard randomNumber > 60 else {
            return
        }
        print("\(text.chestAppears)")
        if randomNumber > 50 {
            activeCharacter.weapon = Weapon(name: "Truc nul", damage: 10, heal: 2)
        } else {
            switch activeCharacter.type {
            case "🗡 Guerrier":
                activeCharacter.weapon = Weapon(name: "Bras de X", damage: 50, heal: 0)
            case "🔮 Mage":
                activeCharacter.weapon = Weapon(name: "Talisman de X", damage: 50, heal: 30)
            case "🔪 Voleur":
                activeCharacter.weapon = Weapon(name: "Shuriken de X", damage: 40, heal: 20)
            case "🏹 Chasseur":
                activeCharacter.weapon = Weapon(name: "Fusil à lunette de X", damage: 40, heal: 20)
            case "🔅 Prêtre":
                activeCharacter.weapon = Weapon(name: "Remède préféré de X", damage: 20, heal: 50)
            default: break
            }
        }
        print("  \(activeCharacter.name), tu équipes le \(activeCharacter.weapon.name)(Dégâts: \(activeCharacter.weapon.damage),Soin: \(activeCharacter.weapon.heal)) que tu viens de trouver!\n  Tu ne le gardes que jusqu'à la fin du combat, fais en bonne usage ou pas...")
    }
    
    /// display a summary of the Game by displaying first the winner .name and .team[] then loser(s) .name and .team[].
    private func displaySummary() { // A TESTER
        for player in playerList where player.state == .inGame {
            print("\n🎉 Notre vainqueur \(player.name) et son équipe:")
            for character in player.characterTeam {
                print("\(character.description)")
            }
            break
        }
        print("\nEt le(s) perdant(s):\n")
        for player in playerList where player.state == .out {
            print("😭 \(player.name) et son équipe:")
            for character in player.characterTeam{
                print("\(character.description)")
            }
        }
        print("\(text.breakingLine)")
    }
    
    /// create an opponantList[] without activePlayer.
    private func setOpponantList(without activePlayer: Player) -> [Player] {
        var opponantList: [Player] = []
        for player in playerList where player.state == .inGame && player.name != activePlayer.name {
            opponantList.append(player)
        }
        return opponantList
    }
    
    /// selectActiveCharacter(), check if thereIsAnyChest() for him, selectTargetCharacter() then if targetCharacter .willBeHealed then activeCharacter heal() him, if targetCharacter .willBeAttacked then activeCharacter attack() him.
    private func combatPhase(between activePlayer: Player, and opponantList: [Player]) {
        let activeCharacter = activePlayer.selectActiveCharacter()
        let trueWeapon = activeCharacter.weapon
        isThereAnyChest(for: activeCharacter)
        let targetCharacter = activePlayer.selectTargetCharacter(incl: opponantList)
        if targetCharacter.state == .willBeHealed {
            activeCharacter.heal(targetCharacter)
        } else if targetCharacter.state == .willBeAttacked {
            activeCharacter.attack(targetCharacter)
        }
        activeCharacter.weapon = trueWeapon
        activeCharacter.state = .notATarget
    }
    
    /// run the turn based game: for each Player, if he's in .inGame, set his opponant list then enter combatPhase(). Re-do while there is more than one Player which state is .inGame, else displaySummary() of the game and exit the method.
    private func game() {
        var howManyTurns = 0
        while true {
            for activePlayer in playerList {
                guard activePlayer.state == .inGame else {
                    continue
                }
                let opponantList = setOpponantList(without: activePlayer)
                combatPhase(between: activePlayer, and: opponantList)
                
                if numberOfOutPlayer(in: opponantList) == opponantList.count {
                    print("\n🎉 Le vainqueur est: \(activePlayer.name) en \(howManyTurns) tours.\n")
                    print("\(text.summary)")
                    displaySummary()
                    return
                }
                howManyTurns += 1
            }
        }
    }
    
    /// run the two main methods of Game, setPlayers() then game().
    private func startGame() {
        print(text.welcome)
        setPlayers()
        game()
    }
    
    /// remove elements from array : playerNameList, playerList, characterNameList to get back to default value.
    private func clearLists() {
        Player.clearCharacterNameList()
        playerNameList.removeAll()
        playerList.removeAll()
    }
    
    /// startGame then propose to players to playAgain, if it's the case clearLists() and repeat startGame again, if not program ends.
    func loopedGame() {
        var playAgain = true
        var noAnswer: Bool
        repeat {
            startGame()
            print(text.wannaPlayAgain)
            noAnswer = true
            while noAnswer {
                if let readAnswer = readLine()?.trimWhiteSpaces {
                    switch readAnswer{
                    case "1" :
                        noAnswer = false
                        clearLists()
                    case "2" :
                        noAnswer = false
                        playAgain = false
                        print(text.seeYouSoon)
                    default : print(text.selectWithNumber)
                    }
                }
            }
        } while playAgain
    }
}
