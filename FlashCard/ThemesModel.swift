//
//  ThemeContent.swift
//  FlashCard
//
//  Created by Olivier Lambert Rouillard on 2023-09-10.
//

import Foundation

struct ThemesModel<levels: Hashable>  {
    private(set) var themes: [DeckModel<levels>] = []


//    init() {
//        themes.append(DeckModel<levels>())
//    }

    mutating func addTheme(themeName: String) {
        themes.append(DeckModel<levels>(name: themeName))
    }

    func addWord(theme: String, word: String, traduction: String) {
//        if let deck = themes[theme]?.deck {
//            deck.addWord(level: Constant.level.beginner, word: word, traduction: traduction)
//        }
    }

    func promoteWord(card: DeckModel<Constant.level>.Card) {
//        model.promoteWord(card: card, promotingTo: Constant.level(rawValue: card.currentLevel.rawValue + 1))
    }

    func downgradeWord(card: DeckModel<Constant.level>.Card) {
//        model.downgradeWord(card: card, downgradeTo: Constant.level(rawValue: card.currentLevel.rawValue - 1))
    }

    func removeWord(id: UUID) {
//        model.removeWord(id: id)
    }

//    func json() throws -> Data {
//        try JSONEncoder().encode(self)
//    }
//
//    init(url: URL) throws {
//        let data = try Data(contentsOf: url)
//        self = try ThemesModel(json: data)
//    }
//
//    init(json: Data) throws {
//        self = try JSONDecoder().decode(ThemesModel.self, from: json)
//    }

    init() { }

}
