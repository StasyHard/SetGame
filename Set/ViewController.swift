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
    @IBOutlet weak var dealCardsButton: DealCardsButtonView!
    @IBOutlet weak var timeLabel: UILabel!
    
    //MARK: - Properties
    private let game = SetGame()
    private var timer = Timer()
    private var timeCounter = 0
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        game.delegate = self
        game.start()
        runTimer()
    }
    
    //MARK: - IBAction
    @IBAction func touchCard(_ sender: CardView) {
        game.cardIsTapped(card: sender.card)
    }
    
    @IBAction func dealCards(_ sender: DealCardsButtonView) {
        game.dealCards()
    }
    
    @IBAction func restartGame(_ sender: BlueButtonView) {
        for cardView in cardsView {
            cardView.removeCard()
        }
        dealCardsButton.setDefaultState()
        game.restart()
        runTimer()
    }
}

// MARK: - Timer
extension ViewController {
    
    //MARK: - Private metods
    private func runTimer() {
        resetParameters()
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(self.updateTimer),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    private func resetParameters() {
        timer.invalidate()
        timeCounter = 0
        timeLabel.text = "TIME: " + timeString(time: timeCounter)
    }
    
    @objc private func updateTimer() {
        timeCounter += 1
        timeLabel.text = "TIME: " + timeString(time: timeCounter)
    }
    
    private func timeString(time: Int) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        if hours == 0 && minutes == 0 {
            return String("\(seconds)s")
        } else if hours == 0 {
            return String("\(minutes)m\(seconds)s")
        } else {
            return String("\(hours)h\(minutes)m\(seconds)s")
        }
    }
}

//MARK: - GameActionsProtocol
extension ViewController: GameActionsProtocol {
    //MARK: - Delegate metods
    func takeCard(card: Card) {
        for view in cardsView {
            if view.card == nil {
                view.card = card
                break
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
    
    func removeСards(_ cards: [Card]) {
        for cardView in self.cardsView {
            for card in cards {
                if cardView.card?.id == card.id {
                    self.removeAnimation(cardView: cardView)
                }
            }
        }
    }
    
    func gameCardsIsFull(_ state: Bool) {
        dealCardsButton.changeState(state)
    }
    
    //MARK: - Private metods
    private func changeState(card: Card, newState: CardState) {
        cardsView.forEach { cardView in
            if cardView.card?.id == card.id {
                cardView.setNewState(newState)
            }
        }
    }
}

//MARK: - Animation
extension ViewController {
    private func removeAnimation(cardView: CardView) {
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5,
                                                       delay: 0.1,
                                                       animations: { cardView.alpha = 0.0 }) {
                                                        animation in
                                                        if animation == .end {
                                                            cardView.removeCard()
                                                            cardView.alpha = 1.0
                                                        }
        }
    }
}
