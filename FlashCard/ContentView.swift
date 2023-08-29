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
                VStack(spacing: -20) {
                    deck(level: CardContent.level.beginner)
                    deck(level: CardContent.level.intermediate)
                    deck(level: CardContent.level.advanced)
                    deck(level: CardContent.level.expert)
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
    func deck(level: CardContent.level) -> some View {
        ZStack {
            ZStack {
                deckBaseView(level: level).padding()
                ForEach(flashCard.model.cards) { card in
                    if card.currentLevel == level {
                        FlashCardView(card: card)
                            .offset(y: Double(card.id) * -3) //figure out the offset
                            .padding()
                    }
                }
            }
            badge(level: level)
        }.padding(.vertical)
    }
    
    @ViewBuilder
    func badge(level: CardContent.level) -> some View {
        let numberOfcard = numberOfCard(in: level)
        ZStack {
            Circle().scale(0.25)
            Circle().scale(0.24).foregroundColor(.white)
            Text(numberOfcard).bold()
        }.offset(x: -130, y: -80)
    }
    
    func numberOfCard(in level: CardContent.level) -> String {
        var numberOfCard = 0
        for card in flashCard.model.cards {
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
