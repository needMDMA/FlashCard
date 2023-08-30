//
//  CardContent.swift
//  FlashCard
//
//  Created by Olivier Lambert Rouillard on 2023-08-22.
//

import Foundation

struct CardContent {
    enum level: Int, CaseIterable {
        case beginner = 0, intermediate ,advanced ,expert
    }
    
    private(set) var cards: [Card] = []
    
    init() {
        cards.append(Card(word: "Dog", traduction: "Chien", id: 0))
        cards.append(Card(word: "Cat", traduction: "Chat", id: 1))
        cards.append(Card(word: "Beer", traduction: "Bière", id: 2))
        cards.append(Card(word: "Wine", traduction: "Vin", id: 3))
    }
    
    mutating func addWord(word: String, traduction: String) {
        cards.append(Card(word: word, traduction: traduction, id: cards.count))
    }
    
    mutating func promoteWord(card: Card) {
        let id = card.id
        if cards[id].currentLevel == .expert {
            return
        }
        
        if cards[id].score < 2 {
            cards[id].score += 1
        }
        if cards[id].score == 2 {
            cards[id].score = 0
            if let promotedLevel = level(rawValue: (card.currentLevel.rawValue + 1)) {
                cards[id].currentLevel = promotedLevel
            }
        }
    }
    mutating func downgradeWord(card: Card) {
        let id = card.id
        if cards[id].score > 0 {
            cards[id].score -= 1
        }
        if cards[id].score == 0 {
            if let downgradeLevel = level(rawValue: (card.currentLevel.rawValue - 1)) {
                cards[card.id].currentLevel = downgradeLevel
            }
        }
    }
    
    struct Card: Identifiable {
        var currentLevel = level.beginner
        var score: Int = 0
        let word: String
        let traduction: String
        let id: Int
    }
}
