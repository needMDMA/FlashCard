//
//  FlashCard.swift
//  FlashCard
//
//  Created by Olivier Lambert Rouillard on 2023-08-22.
//

import Foundation

class FlashCard: ObservableObject {
    
    @Published private(set) var model: CardContent
    
    init() {
        model = CardContent()
    }
    
    func getCards(for level: CardContent.level) -> [CardContent.Card] {
        var cards: [CardContent.Card] = []
        print(level)
        for card in model.cards {
            if card.currentLevel == level {
                cards.append(card)
            }
        }
        print(cards)
        return cards
    }
    
    func addWord(word: String, traduction: String) {
        model.addWord(word: word, traduction: traduction)
    }
    
    func promoteWord(card: CardContent.Card) {
        model.promoteWord(card: card)
    }
    
    func downgradeWord(card: CardContent.Card) {
        model.downgradeWord(card: card)
    }
}
