//
//  RemoveWordView.swift
//  FlashCard
//
//  Created by Olivier Lambert Rouillard on 2023-09-07.
//

import SwiftUI

struct RemoveWordView: View {
    @EnvironmentObject var flashCard: FlashCard
    @State var showingPopover = false
    
    var body: some View {
        Button {
            showingPopover = true
        }label: {
            Text("Remove Word")
        }.popover(isPresented: $showingPopover) {
            wordList
                .padding()
                .frame(minWidth: 300, minHeight: 100)
        }
    }
    
    var wordList: some View {
        List {
            let deck = flashCard.model.deck
            ForEach(Constant.level.allCases, id: \.self) { level in
                if let levelWords = deck[level] {
                    ForEach(levelWords) { word in
                        removeWordButton(word: word.word, id: word.id)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func removeWordButton(word: String, id: UUID) -> some View {
        HStack {
            Button {
                flashCard.removeWord(id: id)
            } label: {
                Image(systemName: "minus.circle.fill").foregroundColor(.red)
            }.buttonStyle(.plain)
            Text(word)
        }
    }
}

struct RemoveWordView_Previews: PreviewProvider {
    static var previews: some View {
        RemoveWordView().environmentObject(FlashCard())
    }
}
