//
//  TextField+Extension.swift
//  Movie
//
//  Created by 전준영 on 6/6/24.
//

import UIKit

extension UITextField {
    
    func setUITextField(backgroundColor: UIColor, borderStyle: UITextField.BorderStyle, placeholder: String, tintColor: UIColor, textAlignment: NSTextAlignment, borderWidth: Double, borderColor: CGColor, textColor: UIColor) {
        self.backgroundColor = backgroundColor
        self.borderStyle = borderStyle
        self.placeholder = placeholder
        self.tintColor = tintColor
        self.textAlignment = textAlignment
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor
        self.textColor = textColor
    }
    
}
