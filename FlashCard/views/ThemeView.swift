//
//  ThemeView.swift
//  FlashCard
//
//  Created by Olivier Lambert Rouillard on 2023-09-10.
//

import SwiftUI

struct ThemeView: View {
    @EnvironmentObject  var flashCardThemes: FlashCard
    
    var body: some View {
        NavigationView {
            List {
                ForEach(flashCardThemes.model.themes) { theme in
                    NavigationLink(theme.name) {
                        FlashCardView(deck: theme.deck)
                    }
                }
            }
            .listStyle(.sidebar)
            
            Text("No selection")
        }
    }
}

struct ThemeView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeView().environmentObject(FlashCard())
    }
}
