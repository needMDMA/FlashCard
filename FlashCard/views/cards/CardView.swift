//
//  CardView.swift
//  FlashCard
//
//  Created by Olivier Lambert Rouillard on 2023-08-28.
//

import SwiftUI

struct CardView: View {
    let card: DeckContent<Constant.level>.Card
    let size: CGSize
    @EnvironmentObject var flashCard: FlashCard
    @State var showTraduction = false
    
    var body: some View {
        ZStack {
            answerButtonView
            correctAnswerIndicator
        }
    }
    
    var answerButtonView: some View {
        HStack {
            Spacer()
            wrongButton
            Spacer()
            traductionButton
            Spacer()
            correctButton
            Spacer()
        }.bold()
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
    
    var correctAnswerIndicator: some View {
        Circle()
            .scale(0.05)
            .offset(x: size.width * 0.42, y: size.height * -0.3)
            .foregroundColor(.green)
            .opacity(isPromotable)
    }
    
    var isPromotable: Double {
        if card.score > 0 {
            return 1
        }
        return 0
    }
}

struct FlashCardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: DeckContent.Card(currentLevel: Constant.level.expert, word: "Dog", traduction: "Chien"), size: CGSize(width: Constant.width, height: 300))
            .environmentObject(FlashCard()).aspectRatio(Constant.ratio, contentMode: .fit)
    }
}
