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
    
    //MARK: - Metods
    private func hideCardViewsWithoutCard() {
        cardsView.forEach { cardView in
            if cardView.figure == nil {
                cardView.isHidden = true
            }
        }
    }
    
    //MARK: - IBAction
    @IBAction func dealThreeCard(_ sender: UIButton) {
    }
    
    @IBAction func restartGame(_ sender: UIButton) {
    }
}

//MARK: - GameActionsProtocol
extension ViewController: GameActionsProtocol {
    func takeCards(cards: [Card]) {
        for index in cards.indices {
            if cardsView[index].figure == nil {
                cardsView[index].figure = cards[index].figure
            }
        }
    }
}

