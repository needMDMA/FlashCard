//
//  FlashCardApp.swift
//  FlashCard
//
//  Created by Olivier Lambert Rouillard on 2023-08-21.
//

import SwiftUI
import SwiftData

@main
struct FlashCardApp: App {
    var body: some Scene {
        WindowGroup {
            ThemeView()
        }
        .modelContainer(for: [FlashCard.self])
    }
}
