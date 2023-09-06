//
//  Constant.swift
//  FlashCard
//
//  Created by Olivier Lambert Rouillard on 2023-08-30.
//

import Foundation

struct Constant {
    enum level: Int, Hashable, Codable {
        case beginner = 0, intermediate ,advanced ,expert
    }
}
