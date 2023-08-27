//
//  FlashCard.swift
//  FlashCard
//
//  Created by Olivier Lambert Rouillard on 2023-08-22.
//

import Foundation

class FlashCard: ObservableObject {
    
    @Published var cards: [CardContent.Card] = []
    
    init() {
        cards.append(CardContent.Card(word: "Dog", traduction: "Chien", id: 0))
        cards.append(CardContent.Card(word: "Cat", traduction: "Chat", id: 1))
    }
    
    func addWord(word: String, traduction: String) {
        cards.append(CardContent.Card(word: word, traduction: traduction, id: cards.count))
    }
    
    func promoteWord(id: Int) {
        cards[id].currentCategory = CardContent.category.beginner
    }
    
}
