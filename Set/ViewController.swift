//
//  ViewController.swift
//  Set
//
//  Created by Anastasia Reyngardt on 23.03.2020.
//  Copyright © 2020 GermanyHome. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - IBOutlet
    @IBOutlet var cardsView: [CardView]!
    @IBOutlet weak var timeLabel: UILabel!
    
    //MARK: - Properties
    let game = SetGame()
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        game.delegate = self
        game.start()
        hideCardViewsWithoutCard()
    }
    
    //MARK: - Private metods
    private func hideCardViewsWithoutCard() {
        cardsView.forEach { cardView in
            if cardView.card == nil {
                cardView.isHidden = true
            }
        }
    }
    
    //MARK: - IBAction
    @IBAction func touchCard(_ sender: CardView) {
        game.cardIsTapped(card: sender.card)
    }
    
    @IBAction func dealThreeCard(_ sender: UIButton) {
    }
    
    @IBAction func restartGame(_ sender: UIButton) {
    }
}

//MARK: - GameActionsProtocol
extension ViewController: GameActionsProtocol {
    
    func takeCards(cards: [Card]) {
        for card in cards {
            for view in cardsView {
                if view.card == nil {
                    view.card = card
                    break
                }
            }
        }
    }
    
    func cardIsSelected(_ card: Card) {
        cardsView.forEach { cardView in
            if cardView.card?.id == card.id {
                cardView.setNewState(state: .selected)
            }
        }
    }
    
    func cardsIsSet(_ cards: [Card]) {
        for card in cards {
            for cardView in cardsView {
                if cardView.card?.id == card.id {
                    cardView.setNewState(state: .set)
                }
            }
        }
    }
    
    func cardsNotSet(_ cards: [Card]) {
        for card in cards {
            for cardView in cardsView {
                if cardView.card?.id == card.id {
                    cardView.setNewState(state: .notSet)
                }
            }
        }
    }
    
    func cardsIsNotSelected(_ cards: [Card]) {
        for card in cards {
            for cardView in cardsView {
                if cardView.card?.id == card.id {
                    cardView.setNewState(state: .notSelected)
                }
            }
        }
    }
    
    func cardIsNotSelected(_ card: Card) {
        cardsView.forEach { cardView in
            if cardView.card?.id == card.id {
                cardView.setNewState(state: .notSelected)
            }
        }
    }
}
