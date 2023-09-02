//
//  deckBaseView.swift
//  FlashCard
//
//  Created by Olivier Lambert Rouillard on 2023-08-28.
//

import SwiftUI

struct deckBaseView: View {
    let level: Constant.level
    let cornerRadius: CGFloat = 40.0
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius).foregroundColor(levelColor)
            RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: 1)
            Text(levelString).bold().font(.largeTitle)
        }
        .aspectRatio(5/2, contentMode: .fill)
    }
    
    var levelString: String {
        switch level {
        case .beginner:
            return "Beginner"
        case .intermediate:
            return "Intermediate"
        case .advanced:
            return "Advanced"
        case .expert:
            return "Expert"
        }
    }
    
    var levelColor: Color {
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

struct deckBaseView_Previews: PreviewProvider {
    static var previews: some View {
        deckBaseView(level: Constant.level.beginner)
    }
}
