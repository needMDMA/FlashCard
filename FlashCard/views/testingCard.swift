//
//  testingCard.swift
//  FlashCard
//
//  Created by Olivier Lambert Rouillard on 2023-09-02.
//

import SwiftUI

struct testingCard: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 30)
            .aspectRatio(2/1, contentMode: .fit)
    }
}

struct testingCard_Previews: PreviewProvider {
    static var previews: some View {
        testingCard()
    }
}
