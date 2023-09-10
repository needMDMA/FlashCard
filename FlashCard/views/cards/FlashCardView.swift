//
//  ContentView.swift
//  FlashCard
//
//  Created by Olivier Lambert Rouillard on 2023-08-21.
//

import SwiftUI

struct FlashCardView: View {
    @EnvironmentObject var flashCard: FlashCard

    var body: some View {
        VStack{
//            AddWordView()
            DeckListView()
//            RemoveWordView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FlashCardView().environmentObject(FlashCard())
            .frame(width: Constant.width, height: Constant.height)
    }
}
