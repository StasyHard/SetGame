//
//  SetGame.swift
//  Set
//
//  Created by Anastasia Reyngardt on 23.03.2020.
//  Copyright © 2020 GermanyHome. All rights reserved.
//

import Foundation

protocol GameActionsProtocol: class {
    func takeCard(card: Card)
    func takeCard(_ card: Card, withState state: CardState)
    func gameCardsIsFull(_ state: Bool)
    func removeСards(_ cards: [Card])
}

final class SetGame {
    //MARK: - Properties
    weak var delegate: GameActionsProtocol?
    
    private var deck = [Card]()
    private var gameCards = [Card]()
    private var selectedCards = [Card]()
    
    //MARK: - Open metods    
    func start() {
        createDeck()
        while gameCards.count < 12 {
            let card = deck.removeLast()
            gameCards.append(card)
            delegate?.takeCard(card: card)
        }
    }
    
    func cardIsTapped(card: Card?) {
        guard let card = card else { return }
        var thisCardIsSelectedAlready = false
        if !selectedCards.isEmpty {
            thisCardIsSelectedAlready = checkCardForAvailabilityInSelectedCards(card: card)
        }
        if !thisCardIsSelectedAlready {
            if selectedCards.count == 3 {
                selectedCards.forEach { card in
                    delegate?.takeCard(card, withState: .notSelected)
                }
                selectedCards.removeAll()
            }
            selectedCards.append(card)
            switch selectedCards.count {
            case 1...2:
                delegate?.takeCard(card, withState: .selected)
            case 3:
                if checkSet() {
                    setActions()
                } else {
                    notSetActions()
                }
            default: break
            }
        } else {
            delegate?.takeCard(card, withState: .notSelected)
            selectedCards.removeAll { selectedCard in
                selectedCard.id == card.id
            }
            selectedCards.forEach { selectedCard in
                delegate?.takeCard(selectedCard, withState: .selected)
            }
        }
    }
    
    func dealCards() {
        if deck.count >= 3 && gameCards.count < 24 {
            for _ in 1...3 {
                let card = deck.removeLast()
                gameCards.append(card)
                delegate?.takeCard(card: card)
            }
            if gameCards.count == 24 || deck.count < 3 {
                delegate?.gameCardsIsFull(true)
            }
        }
    }
    
    func restart() {
        deck.removeAll()
        gameCards.removeAll()
        selectedCards.removeAll()
        start()
    }
    
    //MARK: - Private metods
    private func createDeck() {
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
    
    private func checkCardForAvailabilityInSelectedCards(card: Card) -> Bool {
        var isSelected = false
        selectedCards.forEach { selectedCard in
            if selectedCard.id == card.id {
                isSelected = true
                return
            }
        }
        return isSelected
    }
    
    private func checkSet() -> Bool {
        let figure1 = selectedCards[0].figure
        let figure2 = selectedCards[1].figure
        let figure3 = selectedCards[2].figure
        if (figure1.type == figure2.type && figure2.type == figure3.type && figure1.type == figure3.type) || (figure1.type != figure2.type && figure2.type != figure3.type && figure1.type != figure3.type) {
            if (figure1.count == figure2.count && figure2.count == figure3.count && figure1.count == figure3.count) || (figure1.count != figure2.count && figure2.count != figure3.count && figure1.count != figure3.count) {
                if (figure1.color == figure2.color && figure2.color == figure3.color && figure1.color == figure3.color) || (figure1.color != figure2.color && figure2.color != figure3.color && figure1.color != figure3.color) {
                    if  (figure1.fill == figure2.fill && figure2.fill == figure3.fill && figure1.fill == figure3.fill) || (figure1.fill != figure2.fill && figure2.fill != figure3.fill && figure1.fill != figure3.fill) {
                        return true
                    }
                }
            }
        }
        return false
    }
    
    private func setActions() {
        selectedCards.forEach { card in
            delegate?.takeCard(card, withState: .set)
            gameCards.forEach { gameCard in
                gameCards.removeAll { gameCard in
                    gameCard.id == card.id
                }
            }
        }
        delegate?.removeСards(selectedCards)
        selectedCards.removeAll()
        if deck.count >= 3 {
            delegate?.gameCardsIsFull(false)
        }
    }
    
    private func notSetActions() {
        selectedCards.forEach { card in
            delegate?.takeCard(card, withState: .notSet)
        }
    }
}
