//
//  CardContent.swift
//  FlashCard
//
//  Created by Olivier Lambert Rouillard on 2023-08-22.
//

import Foundation

struct CardContent {
    enum level: Int {
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
        if let promotedLevel = level(rawValue: (card.currentLevel.rawValue + 1)) {
            cards[card.id].currentLevel = promotedLevel
        }
    }
    mutating func downgradeWord(card: Card) {
        if let downgradeLevel = level(rawValue: (card.currentLevel.rawValue - 1)) {
            cards[card.id].currentLevel = downgradeLevel
        }
    }
    
    struct Card: Identifiable {
        var currentLevel = level.beginner
        let word: String
        let traduction: String
        var wrongCount: Int = 0
        var correctCount: Int = 0
        let id: Int
    }
}
