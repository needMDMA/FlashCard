//
//  CardContent.swift
//  FlashCard
//
//  Created by Olivier Lambert Rouillard on 2023-08-22.
//

import Foundation

struct DeckContent<levels: Codable>: Codable where levels: Hashable {
    private var maxScore = 2
    private(set) var deck: [levels: [Card]] = [:]
    var url = URL(string: " ")
    
    mutating func addWord(level: levels, word: String, traduction: String) {
        let newCard = Card(currentLevel: level, word: word, traduction: traduction)
        goBottom(of: level, for: newCard)
        
        
//        if var cards = deck[level] {
//            let newCard = Card(currentLevel: level, word: word, traduction: traduction)
//            cards.insert(newCard, at: 0)
//            deck.updateValue(cards, forKey: level)
//        } else {
//            deck[level] = [Card(currentLevel: level, word: word, traduction: traduction)]
//        }
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

    func json() throws -> Data {
        try JSONEncoder().encode(self)
    }

    init(url: URL) throws {
        let data = try Data(contentsOf: url)
        self = try DeckContent(json: data)
    }
    
    init(json: Data) throws {
        self = try JSONDecoder().decode(DeckContent.self, from: json)
    }
    
    init() {}
    

    
    struct Card: Identifiable, Codable {
        var currentLevel: levels
        var score: Int = 0
        let word: String
        let traduction: String
        var id = UUID()
    }
}
