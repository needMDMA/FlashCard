//
//  ContentView.swift
//  FlashCard
//
//  Created by Olivier Lambert Rouillard on 2023-08-21.
//

import SwiftUI

struct FlashCardView: View {
    @EnvironmentObject  var flashCard: FlashCard
    let index: Int

    var body: some View {
        let theme = flashCard.themes[index]
        VStack{
            DeckListView(index: index)
            HStack {
                Spacer()
                AddWordView(index: index)
                RemoveWordView(index: index)
                TrashThemeView(index: index)
            }.padding()
        }
    }
}
