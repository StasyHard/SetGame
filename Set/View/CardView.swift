//
//  CardView.swift
//  Set
//
//  Created by Anastasia Reyngardt on 23.03.2020.
//  Copyright © 2020 GermanyHome. All rights reserved.
//

import UIKit

enum CardState {
    case selected
    case notSet
    case set
    case notSelected
}

class CardView: UIControl {
    
    //MARK: - Properties
    var card: Card? {
        didSet {
            setNeedsDisplay(bounds)
        }
    }
    private let padding: CGFloat = 6.0
    
    //MARK: - Public metods
    func setNewState(_ state: CardState) {
        switch state {
        case .selected:
            setStroke(width: 3.0, color: #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1))
        case .notSet:
            setStroke(width: 5.0, color: #colorLiteral(red: 0.8073362586, green: 0, blue: 0, alpha: 1))
        case .set:
            setStroke(width: 5.0, color: #colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1))
        case .notSelected:
            layer.borderWidth = 0
        }
    }
    
    func removeCard() {
        card = nil
        layer.borderWidth = 0
    }
    
    //MARK: - Private metods
    override func draw(_ rect: CGRect) {
        if card != nil {
            drawCard(in: rect)
            drawFigures(onCard: rect)
        }
    }
    
    private func drawCard(in rect: CGRect) {
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: 10.0)
        roundedRect.addClip()
        UIColor.white.setFill()
        roundedRect.fill()
        UIColor.gray.setStroke()
        roundedRect.stroke()
    }
    
    private func setStroke(width: CGFloat, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        layer.cornerRadius = 10.0
        setNeedsDisplay(bounds)
    }
    
    //MARK: Draw figure metods
    private func drawFigures(onCard rect: CGRect) {
        let rects = rectCount(onCard: rect)
        rects.forEach { rect in
            drawFigureInRect(rect)
        }
    }
    
    private func rectCount(onCard rect: CGRect) -> [CGRect] {
        var rects = [CGRect]()
        
        let rectHeight: CGFloat = rect.height / 3
        let rectWidth: CGFloat = rect.width
        let rect1 = CGRect(x: 0, y: 0, width: rectWidth, height: rectHeight)
        let rect2 = CGRect(x: 0, y: rect1.maxY, width: rectWidth, height: rectHeight)
        let rect3 = CGRect(x: 0, y: rect2.maxY, width: rectWidth, height: rectHeight)
        
        guard let figure = card?.figure else { return rects }
        switch figure.count {
        case .one:
            rects.append(rect2)
        case .two:
            let rect1 = CGRect(x: 0, y: rect1.midY, width: rectWidth, height: rectHeight)
            let rect2 = CGRect(x: 0, y: rect2.midY, width: rectWidth, height: rectHeight)
            rects.append(rect1)
            rects.append(rect2)
        case .three:
            rects.append(rect1)
            rects.append(rect2)
            rects.append(rect3)
        }
        return rects
    }
    
    private func drawFigureInRect(_ rect: CGRect) {
        guard let figure = card?.figure else { return }
        switch figure.type {
        case .oval:
            drawOval(in: rect)
        case .rectangle:
            drawRectangle(in: rect)
        case .triangle:
            drawTriangle(in: rect)
        }
    }
    
    private func drawRectangle(in rect: CGRect) {
        let rectangle = UIBezierPath(roundedRect: CGRect(x: rect.origin.x + padding,
                                                         y: rect.origin.y + padding,
                                                         width: rect.width - padding * 2,
                                                         height: rect.height - padding * 2),
                                     cornerRadius: 2)
        setColorAndFill(on: rectangle)
    }
    
    private func drawOval(in rect: CGRect) {
        let oval = UIBezierPath(ovalIn: CGRect(x: rect.origin.x + padding,
                                               y: rect.origin.y + padding,
                                               width: rect.width - padding * 2,
                                               height: rect.height - padding * 2))
        setColorAndFill(on: oval)
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
        setColorAndFill(on: triangle)
    }
    
    
    private func setColorAndFill(on path: UIBezierPath) {
        guard let figure = card?.figure else { return }
        let color = setColor(for: figure)
        setFill(on: path, color)
    }
    
    private func setColor(for figure: Figure) -> UIColor {
        var color = UIColor()
        switch figure.color {
        case .blue:
            color = .blue
        case .green:
            color = .green
        case .red:
            color = .red
        }
        return color
    }
    
    private func setFill(on path: UIBezierPath, _ color: UIColor) {
        guard let figure = card?.figure else { return }
        switch figure.fill {
        case .filled:
            color.setFill()
            path.fill()
        case .outline:
            color.setStroke()
            path.stroke()
        case .striped:
            let colorFill = color.withAlphaComponent(0.25)
            colorFill.setFill()
            color.setStroke()
            path.fill()
            path.stroke()
        }
    }
}
