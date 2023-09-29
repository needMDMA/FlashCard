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
    @State private var newName = ""
    
    var body: some View {
        let themes = flashCard.themes
        VStack {
            NavigationSplitView {
                List(themes, id: \.self, selection: $selection) { theme in
                    NavigationLink {
                        FlashCardView(index: theme.id)
                    } label: {
                        if isPresented {
                            TextField("Type New Name", text: $newName).onSubmit {
                                flashCard.renameTheme(index: theme.id, to: "Something")
                                isPresented = false
                            }
                        } else {
                            Text(theme.name)
                        }
                    }.contextMenu {
                        Button("Rename") {
                            isPresented = true
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
