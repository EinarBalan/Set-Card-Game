//
//  ViewController.swift
//  Set
//
//  Created by Einar Balan on 8/16/19.
//  Copyright © 2019 Einar Balan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var game = Set()
    
    @IBOutlet var buttonCards: [UIButton]!
    
    private var cardsOnBoard = [Card]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newGame()
    }
    
    private func newGame() {
        game = Set()
        resetBoard()
        updateViewFromModel()
    }
    
    private func resetBoard()  {
        if (cardsOnBoard.count > 0) { //remove all cards currently on the board
            cardsOnBoard.removeAll()
        }
        for _ in 1...12 { //add random cards from deck
            cardsOnBoard += [game.deck.drawCard()]
        }
        for button in buttonCards { //allow refresh of cards since normally it'll only refresh it it's not set yet
            button.setAttributedTitle(nil, for: .normal)
            button.layer.borderColor = UIColor.black.cgColor
        }
    }
    
    
    private func updateViewFromModel() {
        for index in cardsOnBoard.indices {
            let button = buttonCards[index]
            let card = cardsOnBoard[index]
            
            if (button.attributedTitle(for: .normal) == nil) { //only set title if it hasn't been set already
                
                //set initial appearance of cards
                if (!game.matchedCards.contains(card)){
                    button.layer.cornerRadius = 8
                    button.layer.borderColor = UIColor.white.cgColor
                    button.layer.borderWidth = 3
                    button.backgroundColor = UIColor.black
                    
                }
                
                var string = ""
                var color: UIColor = UIColor.red
                var strokeWidth: Double = -1
                
                //assign attributes to UI based on drawn cards from set model
                switch cardsOnBoard[index].shape {
                case .shape1:
                    string = "▲"
                case .shape2:
                    string = "●"
                case .shape3:
                    string = "■"
                }
                
                switch cardsOnBoard[index].number {
                case .one:
                    break
                case .two:
                    string += string
                case .three:
                    string = string + string + string
                }
                
                switch cardsOnBoard[index].color {
                case .color1:
                    color = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
                case .color2:
                    color = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
                case .color3:
                    color = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
                }
                
                switch cardsOnBoard[index].shading {
                case .style1:
                    //filled
                    strokeWidth = -1
                case .style2:
                    //striped
                    color = color.withAlphaComponent(0.4)
                case .style3:
                    //outlined
                    strokeWidth = 5
                }
                
                let attributes: [NSAttributedString.Key: Any] = [
                    NSAttributedString.Key.strokeWidth: strokeWidth,
                    NSAttributedString.Key.foregroundColor: color
                ]
                let attributedString = NSAttributedString(string: string, attributes: attributes)
                
                button.setAttributedTitle(attributedString, for: .normal)
            }
            
            //show selection
            if (game.selectedCards.contains(card)) {
                button.layer.borderColor = UIColor.orange.cgColor
            }
            else {
                button.layer.borderColor = UIColor.white.cgColor
            }
            
            //if matched remove card from board
            if (game.matchedCards.contains(card)){
                button.layer.borderWidth = 0
                button.backgroundColor = UIColor.black
                button.setAttributedTitle(nil, for: .normal)

            }
            
        }
        
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardIndex = buttonCards.firstIndex(of: sender) {
            let card = cardsOnBoard[cardIndex]
            
            //show selection/deselection with blue border
            game.selectCard(card)
            updateViewFromModel()
        }
    }
    
    @IBAction func clickNewGame(_ sender: UIButton) {
        newGame()
    }
    
    @IBAction func dealThreeCards(_ sender: UIButton) {
        if (cardsOnBoard.count < 22) { //only allow draw cards if drawing three cards will result in board with <= 24 cards
            for _ in 1...3 {
                cardsOnBoard.append(game.deck.drawCard())
            }
            updateViewFromModel()
        }
    }
}

