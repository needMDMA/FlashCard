//
//  ContentView.swift
//  FlashCard
//
//  Created by Olivier Lambert Rouillard on 2023-08-21.
//

import SwiftUI

struct word: Identifiable {
    let word: String
    let traduction: String
    let id = UUID()
}

let words: [word] = [word(word: "potato", traduction: "patate"), word(word: "apple", traduction: "pomme"), word(word: "computer", traduction: "ordinateur")]

struct ContentView: View {
    @State var posY:CGFloat = 12
    @State var opacity: Double = 0
    @State var blur: CGFloat = 0
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    posY = -120
                    opacity = 0.9
                    blur = 3
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.largeTitle)
                }
            }.padding()
            Spacer()
            ScrollView
            {
                cards
                cards
            }
        }
    }
    
    var cards: some View {
        ZStack {
            VStack(spacing: posY) {
                ForEach(words) { word in
                    card(word: word.word, traduction: word.traduction)
                }
            }.blur(radius: blur)
            Button {
                posY = 12
                opacity = 0
                blur = 0
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 40).opacity(opacity).foregroundColor(.green).blur(radius: blur)
                    VStack {
                        Spacer()
                        Text("Shame").foregroundColor(.white).font(.largeTitle).opacity(opacity)
                        Spacer()
                    }
                }
            }
        }.padding()
    }
    
    func boostOffset() {
        posY += 10
    }
    
 }
    

struct card: View {
    let word: String
    let traduction: String
     
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 40.0).foregroundColor(.white)
            RoundedRectangle(cornerRadius: 40.0).stroke(lineWidth: 3)
            LazyVStack {
                Spacer()
                Text(word).font(.title).padding()
                Button {
                    
                } label: {
                    Text(traduction)
                }
                Spacer()
                
            }.padding()
        }
        .aspectRatio(5/2, contentMode: .fill)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
