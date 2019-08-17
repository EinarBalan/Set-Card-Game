//
//  Deck.swift
//  Set
//
//  Created by Einar Balan on 8/16/19.
//  Copyright © 2019 Einar Balan. All rights reserved.
//

import Foundation

struct Deck {
    var cards = [Card]()
    
    init() {
        for shape in Card.Shape.allCases {
            for number in Card.Number.allCases {
                for shading in Card.Shading.allCases {
                    for color in Card.Color.allCases {
                        cards += [Card(shape: shape, number: number, shading: shading, color: color)]
                    }
                }
            }
        }
    }
    
    mutating func drawCard() -> Card? {
        return cards.count > 0 ? cards.remove(at: Int.random(in: cards.indices)) : nil
    }
}
