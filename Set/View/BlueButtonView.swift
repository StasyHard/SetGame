//
//  BlueButtonView.swift
//  Set
//
//  Created by Anastasia Reyngardt on 25.03.2020.
//  Copyright © 2020 GermanyHome. All rights reserved.
//

import UIKit

class BlueButtonView: UIButton {

   override init(frame: CGRect) {
          super.init(frame: frame)
          drawButton()
      }
      
      required init?(coder: NSCoder) {
          super.init(coder: coder)
          drawButton()
      }
      
      private func drawButton() {
          backgroundColor = #colorLiteral(red: 0.3468416333, green: 0.8462669253, blue: 0.9928761125, alpha: 1)
          layer.cornerRadius = 5.0
          clipsToBounds = true
          layer.borderWidth = 1.0
          layer.borderColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
      }

}
