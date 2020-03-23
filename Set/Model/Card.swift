//
//  Card.swift
//  Set
//
//  Created by Anastasia Reyngardt on 23.03.2020.
//  Copyright © 2020 GermanyHome. All rights reserved.
//

import Foundation


struct Card {
    var identifier = 0
    var figure: Figure
    
    private static var identifierFactory = 0
    
    init(figure: Figure) {
        self.figure = figure
        self.identifier = Card.getUniqueIdentifier()
    }
    
    private static func getUniqueIdentifier() -> Int  {
        Card.identifierFactory += 1
        return identifierFactory
    }

//    mutating func changeIsMatched() {
//        if isMatched == false {
//            isMatched = true
//        }
//    }
}
