//
//  RecommendCollectionViewCell.swift
//  MediaProject
//
//  Created by 전준영 on 6/24/24.
//

import UIKit
import Kingfisher

class RecommendCollectionViewCell: BaseCollectionViewCell {
    
    let movieImageView = UIImageView()
    
    
    override func configureHierarchy() {
        contentView.addSubview(movieImageView)
    }
    
    override func configureLayout() {
        movieImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
    override func configureUI() {
        movieImageView.backgroundColor = .systemMint
        movieImageView.setImageViewUI(contentMode: .scaleAspectFill, cornerRadius: 5)
        movieImageView.layer.masksToBounds = true
    }
    
    
    func configureData(data: URL?) {
        
        movieImageView.kf.setImage(with: data)

    }
    
}
