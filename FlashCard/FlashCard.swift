//
//  FlashCard.swift
//  FlashCard
//
//  Created by Olivier Lambert Rouillard on 2023-08-22.
//

import Foundation
import UniformTypeIdentifiers
import SwiftUI

class FlashCard: ReferenceFileDocument {
    func snapshot(contentType: UTType) throws -> Data {
        try JSONEncoder().encode(themes)
    }
    
    func fileWrapper(snapshot: Data, configuration: WriteConfiguration) throws -> FileWrapper {
        return FileWrapper(regularFileWithContents: snapshot)
    }
        
    static var readableContentTypes: [UTType] { [.json] }
    
    required init(configuration: ReadConfiguration) throws {
        if let data = configuration.file.regularFileContents {
            themes = try JSONDecoder().decode([DeckModel<Constant.level>].self, from: data)
        } else {
            throw CocoaError(.fileReadCorruptFile)
        }
    }
    
    init() { }

    @Published var themes: [DeckModel<Constant.level>] = []
    
    
    var themeNames: [String] {
        themes.map { $0.name }
    }
    
    func deck(themeName: String) -> [Constant.level : [DeckModel<Constant.level>.Card]] {
        themes.filter { $0.name == themeName }[0].deck
    }
    
    func firstCard(index: Int, level: Constant.level) -> DeckModel<Constant.level>.Card? {
        let deck = themes[index].deck
        if let cards = deck[level], cards.count > 0 {
            return cards[cards.count-1]
        }
        return nil
    }

    func addTheme(themeName: String) {
        var newTheme = DeckModel<Constant.level>(id: themes.count, name: themeName)
        newTheme.addWord(level: Constant.level.beginner, word: "AAA", traduction: "BBB")
        themes.append(newTheme)
    }
    
    func renameTheme(index: Int, to newName: String) {
       themes[index].rename(newName)
    }
    
    func removeTheme(id: Int) {
        themes.remove(at: id)
        for i in 0..<themes.count {
            themes[i].newId(id: i)
        }
    }

    func addWord(index: Int, word: String, traduction: String) {
        themes[index].addWord(
            level: Constant.level.beginner,
            word: word,
            traduction: traduction
        )
    }

    func promoteWord(index: Int, card: DeckModel<Constant.level>.Card) {
        themes[index].promoteWord(
            card: card,
            promotingTo: Constant.level(rawValue: card.currentLevel.rawValue + 1)
        )
    }

    func downgradeWord(index: Int, card: DeckModel<Constant.level>.Card) {
        themes[index].downgradeWord(
            card: card,
            downgradeTo: Constant.level(rawValue: card.currentLevel.rawValue - 1)
        )
    }

//    func removeWord(themeName: String, id: UUID) {
//        if var deck = themesModel.themes[themeName] {
//            deck.removeWord(id: id)
//            themesModel.updateTheme(theme: themeName, deck: deck)
//        }
//    }
}
