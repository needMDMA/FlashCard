//
//  CardView.swift
//  FlashCard
//
//  Created by Olivier Lambert Rouillard on 2023-08-28.
//

import SwiftUI

struct CardView: View {
    @EnvironmentObject var flashCard: FlashCard
    let card: DeckModel<Constant.level>.Card
    let theme: String
    let size: CGSize
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
            flashCard.promoteWord(theme: theme, card: card)
        }label: {
            Image(systemName: "checkmark")
        }
        .buttonStyle(.plain)
        .font(.largeTitle)
    }
    
    var wrongButton: some View {
        Button {
            flashCard.downgradeWord(theme: theme, card: card)
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
