//
//  FlashCard.swift
//  FlashCard
//
//  Created by Olivier Lambert Rouillard on 2023-08-22.
//

import Foundation

class FlashCard: ObservableObject {
    
    enum level: Int, CaseIterable {
        case beginner = 0, intermediate ,advanced ,expert
    }
    
    @Published private(set) var model: CardContent
    
    init() {
        model = CardContent()
    }
    
    func getCards(for level: level) -> [CardContent.Card] {
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
