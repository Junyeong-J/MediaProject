//
//  Button+Extension.swift
//  Movie
//
//  Created by 전준영 on 6/7/24.
//

import UIKit

extension UIButton {
    
    func setUIButton(backgroundColor: UIColor, titleColor: UIColor, title: String) {
        self.backgroundColor = backgroundColor
        self.setTitleColor(titleColor, for: .normal)
        self.setTitle(title, for: .normal)
    }
}
