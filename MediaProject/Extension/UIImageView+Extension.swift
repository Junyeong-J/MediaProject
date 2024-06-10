//
//  UIImageView+Extension.swift
//  Movie
//
//  Created by 전준영 on 6/10/24.
//

import UIKit

extension UIImageView {
    
    func setImageViewUI(contentMode: UIView.ContentMode, cornerRadius: Double) {
        
        self.contentMode = contentMode
        self.layer.cornerRadius = cornerRadius
        
    }
    
}
