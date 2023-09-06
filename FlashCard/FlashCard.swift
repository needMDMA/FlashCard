//
//  FlashCard.swift
//  FlashCard
//
//  Created by Olivier Lambert Rouillard on 2023-08-22.
//

import Foundation

class FlashCard: ObservableObject {
    @Published private(set) var model: DeckContent<Constant.level> {
        didSet {
            autosave()
        }
    }

    init() {
        if let url = Autosave.url, let autosavedData = try? DeckContent<Constant.level>(url: url) {
            model = autosavedData
        } else {
            model = DeckContent<Constant.level>()
        }
    }
    
    private struct Autosave {
        static let filename = "deck.data"
        static var url: URL? {
            let fileDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            return fileDirectory?.appendingPathComponent(filename)
        }
    }
    
    func autosave() {
        if let url = Autosave.url {
            save(to: url)
        }
    }
    
    private func save(to url: URL) {
        do {
            let data = try model.json()
            try data.write(to: url)
        } catch {
            print("Failed to save")
        }
    }

    func addWord(word: String, traduction: String) {
        model.addWord(level: Constant.level.beginner, word: word, traduction: traduction)
    }
    
    func promoteWord(card: DeckContent<Constant.level>.Card) {
        model.promoteWord(card: card, promotingTo: Constant.level(rawValue: card.currentLevel.rawValue + 1))
    }
    
    func downgradeWord(card: DeckContent<Constant.level>.Card) {
        model.downgradeWord(card: card, downgradeTo: Constant.level(rawValue: card.currentLevel.rawValue - 1))
    }
}
