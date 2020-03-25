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
    
    @IBAction func dealCards(_ sender: UIButton) {
        game.dealCards()
        cardsView.forEach { cardView in
            if cardView.card != nil && cardView.isHidden == true {
                cardView.isHidden = false
            }
        }
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
    
    func takeCard(_ card: Card, withState state: CardState) {
        switch state {
        case .notSelected:
            changeState(card: card, newState: .notSelected)
        case .selected:
            changeState(card: card, newState: .selected)
        case .notSet:
            changeState(card: card, newState: .notSet)
        case .set:
            changeState(card: card, newState: .set)
        }
    }
    
    private func changeState(card: Card, newState: CardState) {
        cardsView.forEach { cardView in
            if cardView.card?.id == card.id {
                cardView.setNewState(newState)
            }
        }
    }
}
