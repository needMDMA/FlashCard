//
//  CardView.swift
//  FlashCard
//
//  Created by Olivier Lambert Rouillard on 2023-08-28.
//

import SwiftUI

struct CardView: View {
    let card: DeckContent<Constant.level>.Card
    @EnvironmentObject var flashCard: FlashCard
    @State var showTraduction = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 40.0).foregroundColor(cardColor(level: card.currentLevel))
            RoundedRectangle(cornerRadius: 40.0).stroke(lineWidth: 1)
            HStack {
                Spacer()
                wrongButton
                Spacer()
                traductionButton
                Spacer()
                correctButton
                Spacer()
            }.bold()
            Circle()
                .scale(0.05)
                .offset(x: 285, y: -90)
                .foregroundColor(.green)
                .opacity(isPromotable)
        }
        .aspectRatio(5/2, contentMode: .fit)
    }
    
    var isPromotable: Double {
        if card.score > 0 {
            return 1
        }
        return 0
    }
    
    var traductionButton: some View {
        Button {
            showTraduction.toggle()
        } label: {
            if showTraduction {
                Text(card.traduction)
            } else {
                Text(card.word)
            }
        }
        .buttonStyle(.plain)
        .font(.largeTitle)
    }
    
    var correctButton: some View {
        Button {
            flashCard.promoteWord(card: card)
        }label: {
            Image(systemName: "checkmark")
        }
        .buttonStyle(.plain)
        .font(.largeTitle)
    }
    
    var wrongButton: some View {
        Button {
            flashCard.downgradeWord(card: card)
        } label: {
            Image(systemName: "xmark")
        }.buttonStyle(.plain)
            .font(.largeTitle)
    }
    
    
    func cardColor(level: Constant.level) -> Color {
        switch level {
        case .beginner:
            return .red
        case .intermediate:
            return .yellow
        case .advanced:
            return .orange
        case .expert:
            return .green
        }
    }
}

struct FlashCardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: DeckContent.Card(currentLevel: Constant.level.advanced, word: "Dog", traduction: "Chien"))
            .environmentObject(FlashCard())
    }
}
