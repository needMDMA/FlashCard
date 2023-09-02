//
//  CardContent.swift
//  FlashCard
//
//  Created by Olivier Lambert Rouillard on 2023-08-22.
//

import Foundation

struct CardContent<levels> where levels: Hashable{
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
        if card.score > 0 {
            card.score = 0
        } else {
            card.score += 1
        }
        
        var cards = deck[card.currentLevel]!
        var _ = cards.popLast()!
        if card.score > 0 {
            cards.insert(card, at: 0)
            deck.updateValue(cards, forKey: card.currentLevel)
        } else {
            if let promotingTo = promotingTo {
                deck.updateValue(cards, forKey: card.currentLevel)
                card.currentLevel = promotingTo
                if var cards = deck[promotingTo] {
                    cards.insert(card, at: 0)
                    deck.updateValue(cards, forKey: promotingTo)
                } else {
                    deck[promotingTo] = [card]
                }
            } else {
                // go bottom of the pile
            }
        }
    }
    
    mutating func downgradeWord(card: Card, downgradeTo: levels?) {
        var card = card
        if card.score >= 0 {
            card.score -= 1
        }
        
        var cards = deck[card.currentLevel]!
        var _ = cards.popLast()!
        if card.score >= 0 {
            cards.insert(card, at: 0)
            deck.updateValue(cards, forKey: card.currentLevel)
        } else {
            if let downgradeTo = downgradeTo {
                deck.updateValue(cards, forKey: card.currentLevel)
                card.currentLevel = downgradeTo
                if var cards = deck[downgradeTo] {
                    cards.insert(card, at: 0)
                    deck.updateValue(cards, forKey: downgradeTo)
                } else {
                    deck[downgradeTo] = [card]
                }
            }
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
