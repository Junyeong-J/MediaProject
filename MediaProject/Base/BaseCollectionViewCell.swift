//
//  BaseCollectionViewCell.swift
//  MediaProject
//
//  Created by 전준영 on 6/30/24.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    func configureHierarchy(){
        
    }
    
    func configureLayout(){
        
    }
    
    func configureUI(){
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
