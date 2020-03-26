//
//  DealCardsButtonView.swift
//  Set
//
//  Created by Anastasia Reyngardt on 25.03.2020.
//  Copyright © 2020 GermanyHome. All rights reserved.
//

import UIKit

class DealCardsButtonView: BlueButtonView {
    
    func changeState(_ newState: Bool) {
        isHidden = newState
    }
    
    func setDefaultState() {
        isHidden = false
    }

}