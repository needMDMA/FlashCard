//
//  ContentView.swift
//  FlashCard
//
//  Created by Olivier Lambert Rouillard on 2023-08-21.
//

import SwiftUI

struct FlashCardView: View {
    let deck: [Constant.level: [DeckModel<Constant.level>.Card]]

    var body: some View {
        VStack{
            AddWordView(deck: deck)
            DeckListView(deck: deck)
            RemoveWordView(deck: deck)
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        FlashCardView()
//    }
//}
