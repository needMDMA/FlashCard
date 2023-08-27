//
//  FlashCardApp.swift
//  FlashCard
//
//  Created by Olivier Lambert Rouillard on 2023-08-21.
//

import SwiftUI

@main
struct FlashCardApp: App {
    let flashCard = FlashCard()
    var body: some Scene {
        WindowGroup {
            ContentView(flashCard: flashCard)
        }
    }
}
