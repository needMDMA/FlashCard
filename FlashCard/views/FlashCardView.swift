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

struct FlashCardView: View {
    @EnvironmentObject var flashCard: FlashCard

    var body: some View {
        VStack{
            AddWordView()
            deck(Constant.level.beginner)
            deck(Constant.level.intermediate)
            deck(Constant.level.advanced)
            deck(Constant.level.expert)
            removeWordView()
        }.padding()
            .frame(minWidth: 700, minHeight: 1250)
    }
    	
    @ViewBuilder
    func deck(_ level: Constant.level) -> some View {
        ZStack {
            ZStack{
                DeckBaseView(level: level)
                if let cards = flashCard.model.deck[level], cards.count > 0 {
                    CardView(card: cards[cards.count-1])
                }
            }
            badge(level: level)
        }.padding()
    }
    
    @ViewBuilder
    func badge(level: Constant.level) -> some View {
        let numberOfcard = numberOfCard(in: level)
        ZStack {
            Circle().scale(0.25)
            Circle().scale(0.24).foregroundColor(.white)
            Text(numberOfcard).font(.title.bold())
        }.offset(x: -265, y: -80)
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
        FlashCardView().environmentObject(FlashCard())
    }
}
