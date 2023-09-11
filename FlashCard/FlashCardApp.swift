//
//  FlashCardApp.swift
//  FlashCard
//
//  Created by Olivier Lambert Rouillard on 2023-08-21.
//

import SwiftUI

@main
struct FlashCardApp: App {
    var body: some Scene {
        WindowGroup {
            ThemeView().environmentObject(FlashCard())
                .frame(width: Constant.width, height: Constant.height)
        }.windowResizability(.contentSize)
    }
}
