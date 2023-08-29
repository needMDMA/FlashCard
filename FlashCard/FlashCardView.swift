//
//  FlashCardView.swift
//  FlashCard
//
//  Created by Olivier Lambert Rouillard on 2023-08-28.
//

import SwiftUI

struct FlashCardView: View {
    let card: CardContent.Card
    @EnvironmentObject var flashCard: FlashCard
//    let word: String
//    let traduction: String
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
            Circle().scale(0.05).offset(x: 140, y: -50).foregroundColor(.green)
            Circle().scale(0.05).offset(x: 130, y: -50).foregroundColor(.red)
        }
        .aspectRatio(5/2, contentMode: .fill)
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
            .font(.largeTitle)
            .autocorrectionDisabled()
            .foregroundColor(.black)
    }
    
    var correctButton: some View {
        Button {
            flashCard.promoteWord(card: card)
        }label: {
            Image(systemName: "checkmark")
        }.foregroundColor(.white)
    }
    
    var wrongButton: some View {
        Button {
            flashCard.downgradeWord(card: card)
        } label: {
            Image(systemName: "xmark")
        }.foregroundColor(.white)
    }
    
    
    func cardColor(level: CardContent.level) -> Color {
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

//struct FlashCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        FlashCardView(card: CardContent.Card(word: "Dog", traduction: "Chien", id: 0))
//            .environmentObject(FlashCard())
//    }
//}
