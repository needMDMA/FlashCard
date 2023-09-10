//
//  ThemeView.swift
//  FlashCard
//
//  Created by Olivier Lambert Rouillard on 2023-09-10.
//

import SwiftUI

struct ThemeView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink("Test") {
                    FlashCardView()
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
