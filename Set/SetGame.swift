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
    func cardIsSelected(_ card: Card)
    func cardsIsSet(_ cards: [Card])
    func cardsNotSet(_ cards: [Card])
    func cardsIsNotSelected(_ cards: [Card])
    func cardIsNotSelected(_ card: Card)
}

final class SetGame {
    //MARK: - Properties
    weak var delegate: GameActionsProtocol?
    
    private var deck = [Card]()
    private var selectedCards = [Card]()
    
    //MARK: - Life cycle
    init() {
        createDeck()
    }
    
    //MARK: - Open metods
    func start() {
        var gameCards = [Card]()
        for _ in 1...12 {
            let card = deck.removeFirst()
            gameCards.append(card)
        }
        delegate?.takeCards(cards: gameCards)
    }
    
    func cardIsTapped(card: Card?) {
        guard let card = card else { return }
        var thisCardIsSelectedAlready = false
        
        if !selectedCards.isEmpty {
            thisCardIsSelectedAlready = checkCardForAvailabilityInSelectedCards(card: card)
        }
        if !thisCardIsSelectedAlready {
            if selectedCards.count == 3 {
                delegate?.cardsIsNotSelected(selectedCards)
                selectedCards.removeAll()
            }
            selectedCards.append(card)
            switch selectedCards.count {
            case 1...2:
                delegate?.cardIsSelected(card)
            case 3:
                if checkSet() {
                    delegate?.cardsIsSet(selectedCards)
                } else {
                    delegate?.cardsNotSet(selectedCards)
                }
            default: break
            }
        } else {
            delegate?.cardIsNotSelected(card)
            selectedCards.removeAll { selectedCard in
                selectedCard.id == card.id
            }
        }
    }
    
    //MARK: - Private metods
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
}
