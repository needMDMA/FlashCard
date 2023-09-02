//
//  CardContent.swift
//  FlashCard
//
//  Created by Olivier Lambert Rouillard on 2023-08-22.
//

import Foundation

struct CardContent<levels> where levels: Hashable{
    private let maxScore = 2
    private(set) var deck: [levels: [Card]] = [:]
    
    mutating func addWord(level: levels, word: String, traduction: String) {
        if var levelCards = deck[level] {
            levelCards.append(Card(currentLevel: level, word: word, traduction: traduction))
            deck.updateValue(levelCards, forKey: level)
        } else {
            deck[level] = [Card(currentLevel: level, word: word, traduction: traduction)]
        }
    }
    
    mutating func promoteWord(card: Card, promotingTo: levels?) {
        var card = card
        card.score += 1
        
        removeLast(of: card.currentLevel)
        
        if card.score < maxScore {
            goBottom(of: card.currentLevel, for: card)
        } else {
            if let promotingTo = promotingTo {
                card.currentLevel = promotingTo
                card.score = 0
                goBottom(of: promotingTo, for: card)
            } else {
                goBottom(of: card.currentLevel, for: card)
            }
        }
    }
    
    mutating func downgradeWord(card: Card, downgradeTo: levels?) {
        var card = card
        removeLast(of: card.currentLevel)

        if card.score > 0 {
            card.score -= 1
            goBottom(of: card.currentLevel, for: card)
        } else {
            if let downgradeTo = downgradeTo {
                card.currentLevel = downgradeTo
                goBottom(of: downgradeTo, for: card)
            } else {
                goBottom(of: card.currentLevel, for: card)
            }
        }
    }
    
    mutating func removeLast(of level: levels) {
        if var cards = deck[level] {
            cards.removeLast()
            deck.updateValue(cards, forKey: level)
        }
    }
        
    mutating func goBottom(of level: levels, for card: Card) {
        if var cards = deck[level] {
            cards.insert(card, at: 0)
            deck.updateValue(cards, forKey: level)
        } else {
            deck[level] = [card]
        }
    }
    
    struct Card: Identifiable {
        var currentLevel: levels
        var score: Int = 0
        let word: String
        let traduction: String
        let id = UUID()
    }
}
