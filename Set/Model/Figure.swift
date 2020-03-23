//
//  Figure.swift
//  Set
//
//  Created by Anastasia Reyngardt on 23.03.2020.
//  Copyright © 2020 GermanyHome. All rights reserved.
//

import Foundation


struct Figure {
    
    enum TypeFigure: String {
        case oval
        case rectangle
        case triangle

        static let all = [TypeFigure.oval, TypeFigure.rectangle, TypeFigure.triangle]
        }

    enum Count {
        case one
        case two
        case three
        
        static let all = [Count.one, Count.two, Count.three]
    }

    enum Color {
        case blue
        case green
        case red
        
        static let all = [Color.blue, Color.green, Color.red]
    }

    enum Fill {
        case striped
        case filled
        case outline
        
        static let all = [Fill.filled, Fill.outline, Fill.striped]
    }
    
    //MARK: - Properties
    let type: TypeFigure
    let color: Color
    let fill: Fill
    let count: Count
}
