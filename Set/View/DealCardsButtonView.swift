//
//  DealCardsButtonView.swift
//  Set
//
//  Created by Anastasia Reyngardt on 25.03.2020.
//  Copyright © 2020 GermanyHome. All rights reserved.
//

import UIKit

class DealCardsButtonView: BlueButtonView {
    
    //MARK: - Public metods
    func setDefaultState() {
        isHidden = false
    }
    
    func changeState(_ newState: Bool) {
        isHidden = newState
    }
}
