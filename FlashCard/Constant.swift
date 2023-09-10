//
//  Constant.swift
//  FlashCard
//
//  Created by Olivier Lambert Rouillard on 2023-08-30.
//

import SwiftUI

struct Constant {
    static let width: CGFloat = 600
    static let height:CGFloat = 840
    static let ratio: CGFloat = 5/2
    
    static let cornerRadius: CGFloat = 40.0
    
    enum level: Int, Hashable, Codable, CaseIterable {
        case beginner = 0, intermediate, expert
    }
    
    static func levelColor(level: level) -> Color {
        let shade: Double = 0.4
        switch level {
        case .beginner:
            let shade = shade
            return Color(red: shade, green: shade, blue: shade)
        case .intermediate:
            let shade = shade + 0.2
            return Color(red: shade, green: shade, blue: shade)
        case .expert:
            let shade = shade + 0.4
            return Color(red: shade, green: shade, blue: shade)
        }
    }
    
    static func levelTitle(level: level) -> String {
        switch level {
        case .beginner:
            return "Beginner"
        case .intermediate:
            return "Intermediate"
        case .expert:
            return "Expert"
        }
    }
}


