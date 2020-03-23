//
//  CardView.swift
//  Set
//
//  Created by Anastasia Reyngardt on 23.03.2020.
//  Copyright © 2020 GermanyHome. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    var figure: Figure? {
        didSet {
           setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {
        drawCard(in: rect)
    }
    
    private func drawCard(in rect: CGRect) {
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: 10.0)
        roundedRect.addClip()
        UIColor.white.setFill()
        UIColor.gray.setStroke()
        roundedRect.stroke()
        roundedRect.fill()
    }

}
