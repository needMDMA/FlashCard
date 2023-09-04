//
//  DeckStorage.swift
//  FlashCard
//
//  Created by Olivier Lambert Rouillard on 2023-09-03.
//

import Foundation

@MainActor
class DeckStorage: ObservableObject {
    private var deck: Data = Data()
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("deck.data")
    }
    
    func load() async throws {
        let task = Task<Data, Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return Data()
            }
            let dailyScrums = try JSONDecoder().decode(Data.self, from: data)
            return dailyScrums
        }
        let deck = try await task.value
        self.deck = deck
    }
    
    func save(deck: Data) async throws {
            let task = Task {
                let data = try JSONEncoder().encode(deck)
                let outfile = try Self.fileURL()
                try data.write(to: outfile)
            }
            _ = try await task.value
        }
}
