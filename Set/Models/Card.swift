//
//  Card.swift
//  Set
//
//  Created by Einar Balan on 8/16/19.
//  Copyright © 2019 Einar Balan. All rights reserved.
//

import Foundation

struct Card: Equatable, CustomStringConvertible {
    var description: String
    var id: Int
    var shape = Shape.shape1
    var number = Number.one
    var shading = Shading.style1
    var color = Color.color1
    
    init(shape: Shape, number: Number, shading: Shading, color: Color) {
        id = Card.getUniqueId()
        self.shape = shape
        self.number = number
        self.shading = shading
        self.color = color
        description = "[Card \(id) Shape: \(shape), Number: \(number), Shading: \(shading), Color: \(color)]"
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.id == rhs.id
    }
    
    //id generation
    private static var idFactory = 0
    
    private static func getUniqueId() -> Int {
        idFactory += 1
        return idFactory
    }
    
    enum Shape: Equatable, CardTrait {
        case shape1
        case shape2
        case shape3
        
        static var allCases = [Shape.shape1, .shape2, .shape3]
    }
    
    enum Number: Equatable, CardTrait {
        case one
        case two
        case three
        
        static var allCases = [Number.one, .two, .three]
    
    }
    
    enum Shading: Equatable, CardTrait {
        case style1
        case style2
        case style3

        static var allCases = [Shading.style1, .style2, .style3]
    }
    
    enum Color: Equatable, CardTrait {
        case color1
        case color2
        case color3
        
        static var allCases = [Color.color1, Color.color2, Color.color3]
    }

}

protocol CardTrait{
    
}

