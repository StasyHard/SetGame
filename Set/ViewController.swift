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
    let game = SetGame()
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
    }
}

// MARK: - Timer
extension ViewController {
    
    //MARK: - Metods
    private func runTimer() {
        timer.invalidate()
        timeCounter = 0
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(self.updateTimer),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    @objc func updateTimer() {
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
        let delayTime = DispatchTime.now() + 1.0
        DispatchQueue.main.asyncAfter(deadline: delayTime, execute: {
            for cardView in self.cardsView {
                for card in cards {
                    if cardView.card?.id == card.id {
                        cardView.removeCard()
                    }
                }
            }
        })
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
