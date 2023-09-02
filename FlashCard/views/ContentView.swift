//
//  ContentView.swift
//  FlashCard
//
//  Created by Olivier Lambert Rouillard on 2023-08-21.
//

import SwiftUI

struct word: Identifiable {
    let word: String
    let traduction: String
    let id = UUID()
}

struct ContentView: View {
    @EnvironmentObject var flashCard: FlashCard
    @State var newWord = ""
    @State var newWordTraduction = ""
    @State private var showingPopover = false
    var offset = 0.0
    
    
    var body: some View {
        VStack{
            Button {
                showingPopover = true
            }label: {
                Image(systemName: "plus")
            }.popover(isPresented: $showingPopover) {
                addWord
            }
            
            ScrollView {
                VStack() {
                    deck(Constant.level.beginner)
                    deck(Constant.level.intermediate)
                    deck(Constant.level.advanced)
                    deck(Constant.level.expert)
                }
            }
        }
    }
        
    var addWord: some View {
        VStack {
            Form {
                Section(header: Text("new word")){
                    TextField("Word", text: $newWord)
                    TextField("Traduction", text: $newWordTraduction)
                }
            }
            Button("Add") {
                flashCard.addWord(word: newWord, traduction: newWordTraduction)
                showingPopover = false
                newWord = ""
                newWordTraduction = ""
            }
        }
    }
    	
    @ViewBuilder
    func deck(_ level: Constant.level) -> some View {
        ZStack {
            ZStack{
                deckBaseView(level: level)
                let cards = flashCard.model.deck[level] ?? []
                ForEach(cards) { card in
                    FlashCardView(card: card)
                }
            }
            badge(level: level)
        }
    }
    
    @ViewBuilder
    func badge(level: Constant.level) -> some View {
        let numberOfcard = numberOfCard(in: level)
        ZStack {
            Circle().scale(0.25)
            Circle().scale(0.24).foregroundColor(.white)
            Text(numberOfcard).bold()
        }.offset(x: -130, y: -80)
    }
    
    func numberOfCard(in level: Constant.level) -> String {
        var numberOfCard = 0
        for card in flashCard.model.deck[level] ?? [] {
            if card.currentLevel == level {
                numberOfCard += 1
            }
        }
        return "\(numberOfCard)"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(FlashCard())
    }
}
