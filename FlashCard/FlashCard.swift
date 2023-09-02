//
//  FlashCard.swift
//  FlashCard
//
//  Created by Olivier Lambert Rouillard on 2023-08-22.
//

import Foundation

class FlashCard: ObservableObject {
    @Published private(set) var model = CardContent<Constant.level>()

    init() {
        addWord(word: "dog", traduction: "chien")
        addWord(word: "cat", traduction: "Chat")
        addWord(word: "beer", traduction: "biere")
        addWord(word: "wine", traduction: "vin")
    }
    
    func addWord(word: String, traduction: String) {
        model.addWord(level: Constant.level.beginner, word: word, traduction: traduction)
    }
    
    func promoteWord(card: CardContent<Constant.level>.Card) {
        model.promoteWord(card: card, promotingTo: Constant.level(rawValue: card.currentLevel.rawValue + 1))
    }
    
    func downgradeWord(card: CardContent<Constant.level>.Card) {
        model.downgradeWord(card: card, downgradeTo: Constant.level(rawValue: card.currentLevel.rawValue - 1))
    }
}
