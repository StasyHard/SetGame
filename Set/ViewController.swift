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
    @IBOutlet var cardsView: [UIView]!
    @IBOutlet weak var timeLabel: UILabel!
    
    //MARK: - Properties
    let game = SetGame()
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        game.delegate = self
        game.start()
    }
    
//MARK: - IBAction
    @IBAction func dealThreeCard(_ sender: UIButton) {
    }
    
    @IBAction func restartGame(_ sender: UIButton) {
    }
}

extension ViewController: GameActionsProtocol {
    func takeCards(cards: [Card]) {
        print(cards.count)
        for card in 0..<cards.count {
            
        }
    }
    
    
}

