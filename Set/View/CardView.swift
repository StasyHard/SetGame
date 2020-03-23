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
    
    //MARK: - Private metods
    override func draw(_ rect: CGRect) {
        drawCard(in: rect)
        drawFigure(in: rect)
    }
    
    private func drawCard(in rect: CGRect) {
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: 10.0)
        roundedRect.addClip()
        UIColor.white.setFill()
        roundedRect.fill()
        UIColor.gray.setStroke()
        roundedRect.stroke()
    }
    
    //MARK: Draw figure metods
    private func drawFigure(in rect: CGRect) {
        let rect1 = CGRect(x: 0, y: 0, width: rect.width, height: rect.height / 3)
        let rect2 = CGRect(x: 0, y: rect1.maxY, width: rect.width, height: rect.height / 3)
        let rect3 = CGRect(x: 0, y: rect2.maxY, width: rect.width, height: rect.height / 3)
        
        guard let figure = figure else { return }
        
        switch figure.type {
        case .oval:
            switch figure.count {
            case .one:
                drawOval(in: rect2)
            case .two:
                drawOval(in: rect1)
                drawOval(in: rect3)
            case .three:
                drawOval(in: rect1)
                drawOval(in: rect2)
                drawOval(in: rect3)
            }
        case .rectangle:
            switch figure.count {
            case .one:
                drawRectangle(in: rect2)
            case .two:
                drawRectangle(in: rect1)
                drawRectangle(in: rect3)
            case .three:
                drawRectangle(in: rect1)
                drawRectangle(in: rect2)
                drawRectangle(in: rect3)
            }
        case .triangle:
            switch figure.count {
            case .one:
                drawTriangle(in: rect2)
            case .two:
                drawTriangle(in: rect1)
                drawTriangle(in: rect3)
            case .three:
                drawTriangle(in: rect1)
                drawTriangle(in: rect2)
                drawTriangle(in: rect3)
            }
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
    
    
    func setColorAndFill(on path: UIBezierPath) {
        guard let figure = figure else { return }
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
    
    func setFill(on path: UIBezierPath, _ color: UIColor) {
        switch figure!.fill {
        case .filled:
            color.setFill()
            path.fill()
        case .outline:
            color.setStroke()
            path.stroke()
        case .striped:
            let colorFill = color.withAlphaComponent(0.4)
            colorFill.setFill()
            color.setStroke()
            path.fill()
            path.stroke()
        }
    }
}
