//
//  FlashCard.swift
//  FlashCard
//
//  Created by Olivier Lambert Rouillard on 2023-08-22.
//

import Foundation

class FlashCard: ObservableObject {
    @Published private(set) var themes: [String: DeckModel<Constant.level>] = [:]
    
    init() { 
        for name in ["a"] {
            var deck = DeckModel<Constant.level>()
            deck.addWord(level: Constant.level.beginner, word: "AAA", traduction: "AAA")
            themes[name] = deck
        }
    }
    
    var themeNames: [String] {
        print(Array(themes.keys.sorted()))
        return Array(themes.keys.sorted())
    }
    
    func deck(theme: String) -> [Constant.level : [DeckModel<Constant.level>.Card]] {
        themes[theme]!.deck
    }
    
    func firstCard(theme: String, level: Constant.level) -> DeckModel<Constant.level>.Card? {
        if let cards = themes[theme]!.deck[level], cards.count > 0 {
            return cards[cards.count-1]
        }
        return nil
    }

    func addTheme(name: String) {
        themes[name] = DeckModel<Constant.level>()
    }
    
    func renameTheme(from name: String, to new: String) {
        if let theme = themes[name] {
            themes.removeValue(forKey: name)
            themes[new] = theme
        }
    }

    func addWord(themeName: String, word: String, traduction: String) {
//        var deck = themes.remove(at: index)
//        deck.addWord(level: Constant.level.beginner, word: word, traduction: traduction)
//        themes.append(deck)
    }

    func promoteWord(theme: String, card: DeckModel<Constant.level>.Card) {
        if var deck = themes[theme] {
            deck.promoteWord(card: card, promotingTo: Constant.level(rawValue: card.currentLevel.rawValue + 1))
            themes.updateValue(deck, forKey: theme)
        }
    }

    func downgradeWord(theme: String, card: DeckModel<Constant.level>.Card) {
        if var deck = themes[theme] {
            deck.downgradeWord(card: card, downgradeTo: Constant.level(rawValue: card.currentLevel.rawValue - 1))
            themes.updateValue(deck, forKey: theme)
        }
    }

//    func removeWord(themeName: String, id: UUID) {
//        if var deck = themesModel.themes[themeName] {
//            deck.removeWord(id: id)
//            themesModel.updateTheme(theme: themeName, deck: deck)
//        }
//    }
}
