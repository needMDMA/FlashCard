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
    @ObservedObject var flashCard: FlashCard
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
                    deck(currentCategory: .new)
                    deck(currentCategory: .beginner)
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
    func deck(currentCategory: CardContent.category) -> some View {
        ZStack {
            ZStack {
                ForEach(flashCard.cards) { card in
                    if card.currentCategory == currentCategory {
                        cardView(flashCard: flashCard, word: card.word, traduction: card.traduction)
                            .offset(y: Double(card.id) * -3) //figure out the offset
                            .padding()
                    }
                }
            }
            badge
        }.padding(.vertical)
    }
    
    var badge: some View {
        ZStack {
            Circle().scale(0.25)
            //Text("\(flashCard.word)").bold().foregroundColor(.white)
        }.offset(x: -130, y: -80)
    }
}

struct cardView: View {
    let flashCard: FlashCard
    let word: String
    let traduction: String
    @State var guess = "tap for answer"
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 40.0).foregroundColor(.white)
            RoundedRectangle(cornerRadius: 40.0).stroke(lineWidth: 1)
            VStack {
                Text(word).font(.title).padding()
                HStack {
                    Spacer()
                    wrongButton
                    Spacer()
                    traductionButton
                    Spacer()
                    correctButton
                    Spacer()
                }
            }
            Circle().scale(0.05).offset(x: 140, y: -50).foregroundColor(.green)
            Circle().scale(0.05).offset(x: 130, y: -50).foregroundColor(.red)
        }
        .aspectRatio(5/2, contentMode: .fill)
    }
    
    var traductionButton: some View {
        Button {
            guess = traduction
        } label: {
            Text(guess)
        }
    }
    
    var correctButton: some View {
        Button {
            flashCard.promoteWord(id: 0)
        }label: {
            Image(systemName: "checkmark")
        }
    }
    
    var wrongButton: some View {
        Button {
            
        } label: {
            Image(systemName: "xmark")
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let flashCard = FlashCard()
        ContentView(flashCard: flashCard)
    }
}
