//
//  SetGame.swift
//  Set
//
//  Created by Anastasia Reyngardt on 23.03.2020.
//  Copyright © 2020 GermanyHome. All rights reserved.
//

import Foundation

protocol GameActionsProtocol: class {
    func takeCards(cards: [Card])
}

final class SetGame {
    //MARK: - Properties
    weak var delegate: GameActionsProtocol?
    
    private var deck = [Card]()
    
     //MARK: - Life cycle
    init() {
       createDeck()
    }
    
    //MARK: - Open functions
    func createDeck() {
        for type in Figure.TypeFigure.all {
            for count in Figure.Count.all{
                for color in Figure.Color.all {
                    for fill in Figure.Fill.all {
                        let figure = Figure(type: type, color: color, fill: fill, count: count)
                        deck.append(Card(figure: figure))
                    }
                }
            }
        }
        deck.shuffle()
    }
    
    func start() {
        var gameCards = [Card]()
        for _ in 1...12 {
            let card = deck.removeFirst()
            gameCards.append(card)
        }
        print(gameCards.count)
        delegate?.takeCards(cards: gameCards)
}
}
