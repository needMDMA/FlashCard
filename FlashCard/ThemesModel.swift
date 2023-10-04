//
//  ThemeContent.swift
//  FlashCard
//
//  Created by Olivier Lambert Rouillard on 2023-09-10.
//

import Foundation

struct ThemesModel<deck: Hashable> {
    private(set) var themes: [String: deck] = [:]
    
    mutating func addTheme(name: String, deck: deck) {
        themes[name] = deck
    }
    
//    mutating func updateTheme(theme name: String, deck: deck) {
//        themes.updateValue(deck, forKey: name)
//    }
//
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
//
//    init() { }
    
//    struct Theme: Identifiable {
//        var name: String
//        var deck: deck
//        var id = UUID()
//    }
    
}
