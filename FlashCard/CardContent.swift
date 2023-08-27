//
//  CardContent.swift
//  FlashCard
//
//  Created by Olivier Lambert Rouillard on 2023-08-22.
//

import Foundation

struct CardContent {
    
    enum category {
        case new, beginner, learned, mastered
    }
    
    struct Card: Identifiable {
        var currentCategory = category.new
        let word: String
        let traduction: String
        var wrongCount: Int = 0
        var correctCount: Int = 0
        let id: Int
    }
}
