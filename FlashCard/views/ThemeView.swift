//
//  ThemeView.swift
//  FlashCard
//
//  Created by Olivier Lambert Rouillard on 2023-09-10.
//

import SwiftUI

struct ThemeView: View {
    @EnvironmentObject var flashCard: FlashCard
    @State var newThemeName = "Theme Name"
    @State private var isPresented = false
    @State private var selection: String? = nil
    
    var body: some View {
        VStack {
            NavigationSplitView {
                List(flashCard.themes.indices, id: \.self, selection: $selection) { index in
                    let theme = flashCard.themes[index]
                    NavigationLink {
                        FlashCardView(index: theme.id)
                    }label: {
                        if isPresented {
                            TextField(text: $flashCard.themes[index].name) {
                                Text(theme.name)
                            }.onSubmit {
                                isPresented = false
                            }
                        } else {
                            Text(theme.name)
                        }
                    }.contextMenu {
                        Button("Rename"){
                            isPresented = true
                        }
                        Button("Delete") {
                            flashCard.removeTheme(id: index)
                        }
                    }
                }
                newThemeButton
            } detail: {
                Text("click on a theme")
            }
        }
    }
    
    var newThemeButton: some View {
        Button {
            flashCard.addTheme(themeName: newThemeName)
        } label: {
            HStack {
                Image(systemName: "plus.circle")
                Text("New Theme")
                Spacer()
            }
        }.buttonStyle(.plain)
            .padding()
    }
}

struct ThemeView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeView().environmentObject(FlashCard())
    }
}
