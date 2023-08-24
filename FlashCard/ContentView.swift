//
//  ContentView.swift
//  FlashCard
//
//  Created by Olivier Lambert Rouillard on 2023-08-21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.largeTitle)
                }
            }.padding()
            Spacer()
            ScrollView {
                LazyVStack {
                    ForEach(1...10, id: \.self) { count in
                        card
                    }
                }
            }
        }
    }
    
    var card: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 40.0)
            VStack {
                Spacer()
                Text("WORD IN KOREAN").font(.title).padding()
                Text("word in french").font(.headline)
                Spacer()
                
            }.foregroundColor(.white)
        }
        .aspectRatio(5/2, contentMode: .fill)
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
