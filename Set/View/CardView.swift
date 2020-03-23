//
//  CardView.swift
//  Set
//
//  Created by Anastasia Reyngardt on 23.03.2020.
//  Copyright © 2020 GermanyHome. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    //MARK: - Properties
    var figure: Figure? {
        didSet {
            //setNeedsDisplay()
        }
    }
    private let padding: CGFloat = 5.0
    
    //MARK: - Metods
    override func draw(_ rect: CGRect) {
        drawCard(in: rect)
    }
    
    private func drawCard(in rect: CGRect) {
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: 10.0)
        roundedRect.addClip()
        UIColor.white.setFill()
        roundedRect.fill()
        UIColor.gray.setStroke()
        roundedRect.stroke()
    }
    
    //MARK: - Draw figure metods
    private func drawRectangle(in rect: CGRect) {
        let rectangle = UIBezierPath(roundedRect: CGRect(x: rect.origin.x + padding,
                                                         y: rect.origin.y + padding,
                                                         width: rect.width - padding * 2,
                                                         height: rect.height - padding * 2),
                                     cornerRadius: 2)
        //setFill(on: rectangle)
    }
    
    private func drawOval(in rect: CGRect) {
        let oval = UIBezierPath(ovalIn: CGRect(x: rect.origin.x + padding,
                                               y: rect.origin.y + padding,
                                               width: rect.width - padding * 2,
                                               height: rect.height - padding * 2))
        //setFill(on: oval)
    }
    
    private func drawTriangle(in rect: CGRect) {
        let triangle = UIBezierPath()
        let point1 = CGPoint(x: padding, y: rect.origin.y + rect.height - padding)
        let point2 = CGPoint(x: rect.width / 2, y: rect.origin.y + padding)
        let point3 = CGPoint(x: rect.width - padding, y: rect.origin.y + rect.height - padding)
        triangle.move(to: point1)
        triangle.addLine(to: point2)
        triangle.addLine(to: point3)
        triangle.addLine(to: point1)
        //setFill(on: triangle)
    }
    
    //        func setFill(on figure: UIBezierPath) {
    //            let color = setColor(for: figure)
    //            switch figure?.fill {
    //            case .filled:
    //                color.setFill()
    //                figure.fill()
    //            case .outline:
    //                color.setStroke()
    //                figure.stroke()
    //            case .striped:
    //                let colorFill = color.withAlphaComponent(0.4)
    //                colorFill.setFill()
    //                color.setStroke()
    //                figure.fill()
    //                figure.stroke()
    //            case .none:
    //                print("Не пришел цвет фигуры на кнопке")
    //            }
    //        }
    //
    //        private func setColor(for figure: Figure) -> UIColor {
    //            var color = UIColor()
    //            switch figure.color {
    //            case .blue:
    //                color = .blue
    //            case .green:
    //                color = .green
    //            case .red:
    //                color = .red
    //            }
    //            return color
    //        }
    
}
