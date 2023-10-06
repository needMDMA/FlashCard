//
//  CardContent.swift
//  FlashCard
//
//  Created by Olivier Lambert Rouillard on 2023-08-22.
//

import Foundation

struct DeckModel<levels: Hashable>: Hashable, Identifiable {
    private let maxScore = 2
    private(set) var deck: [levels: [Card]] = [:]
    private(set) var id: Int
    var name: String
       
    
    mutating func rename(_ newName: String) {
        name = newName
    }
    
    mutating func newId(id: Int) {
        self.id = id
    }
    
    mutating func addWord(level: levels, word: String, traduction: String) {
        let newCard = Card(currentLevel: level, word: word, traduction: traduction)
        goBottom(of: level, for: newCard)
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
    
    mutating func removeWord(id: UUID) {
        for level in deck.keys {
            if var cards = deck[level] {
                for index in 0..<cards.count {
                    if cards[index].id == id {
                        cards.remove(at: index)
                        deck.updateValue(cards, forKey: level)
                        break
                    }
                }
            }
        }
    }
    
    private mutating func removeLast(of level: levels) {
        if var cards = deck[level] {
            cards.removeLast()
            deck.updateValue(cards, forKey: level)
        }
    }
        
    private mutating func goBottom(of level: levels, for card: Card) {
        if var cards = deck[level] {
            cards.insert(card, at: 0)
            deck.updateValue(cards, forKey: level)
        } else {
            deck[level] = [card]
        }
    }

    struct Card: Identifiable, Hashable {
        var currentLevel: levels
        var score: Int = 0
        let word: String
        let traduction: String
        var id = UUID()
    }
}
