//
//  TrashThemeView.swift
//  FlashCard
//
//  Created by Olivier Lambert Rouillard on 2023-09-11.
//

import SwiftUI

struct TrashThemeView: View {
    @EnvironmentObject  var flashCard: FlashCard
    let theme: String
    
    var body: some View {
        Button {
            
        }label: {
            Image(systemName: "trash")
        }
    }
}

//struct TrashThemeView_Previews: PreviewProvider {
//    static var previews: some View {
//        TrashThemeView()
//    }
//}
