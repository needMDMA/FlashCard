//
//  ThemeListView.swift
//  FlashCard
//
//  Created by Olivier Lambert Rouillard on 2023-09-11.
//

import SwiftUI

struct ThemeListView: View {
    @State private var overText = false
    let name: String
    
    var body: some View {
        HStack {
            Image(systemName: "mail.stack")
            Text(name)
            Spacer()
            listOptionButton
            Text("20")
        }
    }
    
    var listOptionButton: some View {
        Button {
            
        } label: {
            Image(systemName: "ellipsis.circle.fill")
                .opacity(overText ? 1 : 0)
        }.onHover { over in overText = over}
            .buttonStyle(.plain)
    }
}

//struct ThemeListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ThemeListView()
//    }
//}
