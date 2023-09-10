//
//  DeckListView.swift
//  FlashCard
//
//  Created by Olivier Lambert Rouillard on 2023-09-10.
//

import SwiftUI

struct DeckListView: View {
    @EnvironmentObject var flashCard: FlashCard
    
    var body: some View {
        List {
            ForEach(Constant.level.allCases, id: \.self) { level in
                deck(level).aspectRatio(5/2, contentMode: .fit)
            }
        }
    }
    
    @ViewBuilder
    func deck(_ level: Constant.level) -> some View {
        ZStack {
            GeometryReader { geometry in
                ZStack{
                    cardBackground(level: level)
                    if let cards = flashCard.model.deck[level], cards.count > 0 {
                        CardView(card: cards[cards.count-1], size: geometry.size)
                    } else {
                        Text(Constant.levelTitle(level: level)).bold().font(.largeTitle)
                    }
                }
                badge(level: level, size: geometry.size)
            }
        }
    }
    
    @ViewBuilder
    func badge(level: Constant.level, size: CGSize) -> some View {
        let numberOfcard: String = String(flashCard.model.deck[level]?.count ?? 0)
        let circleScale: CGFloat = 0.25
        
        ZStack {
            Circle().scale(circleScale).foregroundColor(.white).shadow(radius: 5)
            Text(numberOfcard).font(.title.bold())
        }.offset(x: size.width * -0.42, y: size.height * -0.3)
    }
    
    @ViewBuilder
    func cardBackground(level: Constant.level) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: Constant.cornerRadius)
                .foregroundColor(Constant.levelColor(level: level))
            RoundedRectangle(cornerRadius: Constant.cornerRadius)
                .strokeBorder(lineWidth: 3)
        }
    }
}

struct DeckListView_Previews: PreviewProvider {
    static var previews: some View {
        DeckListView().environmentObject(FlashCard())
    }
}
