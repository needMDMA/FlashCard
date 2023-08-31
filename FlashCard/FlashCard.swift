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
        addWord(word: "dog", traduction: "chien")
        addWord(word: "cat", traduction: "Chat")
        addWord(word: "beer", traduction: "biere")
        addWord(word: "wine", traduction: "vin")
    }
    
    func getCards(for level: Constant.level) -> [CardContent.Card] {
        var cards: [CardContent.Card] = []
        for card in model.cards {
            if card.currentLevel == level {
                cards.append(card)
            }
        }
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
