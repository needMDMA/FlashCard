//
//  CardContent.swift
//  FlashCard
//
//  Created by Olivier Lambert Rouillard on 2023-08-22.
//

import Foundation

struct CardContent {    
    private(set) var cards: [Card] = []
    
    mutating func addWord(word: String, traduction: String) {
        cards.append(Card(currentLevel: Constant.level.beginner, word: word, traduction: traduction, id: cards.count))
    }
    
    mutating func promoteWord(card: Card) {
        let id = card.id
        switch cards[id].currentLevel {
        case .expert:
            return
        default:
            if cards[id].score < 2 {
                cards[id].score += 1
            }
            if cards[id].score == 2 {
                cards[id].score = 0
                if let promotedLevel = Constant.level(rawValue: (card.currentLevel.rawValue + 1)) {
                    cards[id].currentLevel = promotedLevel
                }
            }
        }
    }
    mutating func downgradeWord(card: Card) {
        let id = card.id
        switch cards[id].currentLevel {
        case .beginner:
            return
        default:
            if cards[id].score > 0 {
                cards[id].score -= 1
            }
            if cards[id].score == 0 {
                if let downgradeLevel = Constant.level(rawValue: (card.currentLevel.rawValue - 1)) {
                    cards[card.id].currentLevel = downgradeLevel
                }
            }
        }
    }
    
    struct Card: Identifiable {
        var currentLevel: Constant.level
        var score: Int = 0
        let word: String
        let traduction: String
        let id: Int
    }
}
