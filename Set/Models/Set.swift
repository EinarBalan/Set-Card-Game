//
//  Set.swift
//  Set
//
//  Created by Einar Balan on 8/16/19.
//  Copyright © 2019 Einar Balan. All rights reserved.
//

import Foundation

struct Set {
    var deck = Deck()
    var selectedCards = [Card]()
    var matchedCards = [Card]()
    
    private(set) var score = 0
    
    mutating func selectCard(_ card: Card){
        if (!selectedCards.contains(card)) { // only add card if it hasn't already been selected
            if (selectedCards.count >= 3) { // only check for match if 3 cards have been selected
                if (checkMatch(for: selectedCards)) {
                    score += 5
                    markSelectionAsMatch()
                }
                else {
                    score -= 1
                }
                selectedCards.removeAll()
                
            }
            
            selectedCards.append(card)
        }
        else if (selectedCards.count < 3){ //only remove card from selection if less than three cards have been selected and card isn't currenlty selected
            selectedCards.remove(at: selectedCards.index(of: card)!)
        } 
    }
    
    private mutating func markSelectionAsMatch() {
        matchedCards += selectedCards
    }
    
    func checkMatch(for selectedCards: [Card]) -> Bool {
        var isMatch = true
        
        //MARK: Match Algorithm (Works...but is it the best way? Probably not.)
        for shape in Card.Shape.allCases {
            let cardsWithShape = selectedCards.filter { return shape == $0.shape} //return array of cards with same trait
            //check if there are all of same trait or none with same trait
            if (cardsWithShape.count > 1 && cardsWithShape.count < selectedCards.count) {
                isMatch = false
                break
            }
        }
        for number in Card.Number.allCases {
            let cardswithNumber = selectedCards.filter { return number == $0.number} //return array of cards with same trait
            
            //check if there are all of same trait or none with same trait
            if (cardswithNumber.count > 1 && cardswithNumber.count < selectedCards.count) {
                isMatch = false
                break
            }
        }
        for shading in Card.Shading.allCases {
            let cardsWithShading = selectedCards.filter { return shading == $0.shading} //return array of cards with same trait
            
            //check if there are all of same trait or none with same trait
            if (cardsWithShading.count > 1 && cardsWithShading.count < selectedCards.count) {
                isMatch = false
                break
            }
        }
        for color in Card.Color.allCases {
            let cardsWithColor = selectedCards.filter { return color == $0.color} //return array of cards with same trait
            
            //check if there are all of same trait or none with same trait
            if (cardsWithColor.count > 1 && cardsWithColor.count < selectedCards.count) {
                isMatch = false
                break
            }
        }
        return isMatch
    }
    
}
