//
//  ContentView.swift
//  FlashCard
//
//  Created by Olivier Lambert Rouillard on 2023-08-21.
//

import SwiftUI

struct FlashCardView: View {
    @EnvironmentObject  var flashCard: FlashCard
    let theme: String

    var body: some View {
        VStack{
            DeckListView(theme: theme)
            HStack {
                Spacer()
                AddWordView(theme: theme)
                RemoveWordView(theme: theme)
                TrashThemeView(theme: theme)
            }.padding()
        }
    }
}
