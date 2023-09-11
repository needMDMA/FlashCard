//
//  AddWordView.swift
//  FlashCard
//
//  Created by Olivier Lambert Rouillard on 2023-09-07.
//

import SwiftUI

struct AddWordView: View {
//    @EnvironmentObject var flashCard: FlashCard
    let deck: [Constant.level: [DeckModel<Constant.level>.Card]]
    @State var newWord = ""
    @State var newWordTraduction = ""
    @State private var showingPopover = false
    
    var body: some View {
        Button {
            showingPopover = true
        }label: {
            Text("Add New Word")
        }.popover(isPresented: $showingPopover) {
            addWord
                .padding()
                .frame(minWidth: 300, minHeight: 100)
        }
    }
    
    var addWord: some View {
        VStack {
            Form {
                Section(header: Text("new word")){
                    TextField("Word", text: $newWord)
                    TextField("Traduction", text: $newWordTraduction)
                }
            }
            Button("Add") {
//                flashCard.addWord(word: newWord, traduction: newWordTraduction)
                showingPopover = false
                newWord = ""
                newWordTraduction = ""
            }
        }
    }
}

//struct AddWordView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddWordView()
//    }
//}
