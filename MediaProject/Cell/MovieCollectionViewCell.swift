//
//  MovieCollectionViewCell.swift
//  MediaProject
//
//  Created by 전준영 on 6/11/24.
//

import UIKit
import SnapKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {
    
    let movieImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        contentView.addSubview(movieImageView)
    }
    
    func configureLayout() {
        movieImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
    func configureUI() {
        movieImageView.setImageViewUI(contentMode: .scaleAspectFill, cornerRadius: 5)
        movieImageView.layer.masksToBounds = true
    }
    
    func configureData(data: MovieData) {
        
        let posterBaseURL = APIURL.posterBaseURL
        if let profilePath = data.poster_path{
            let url = URL(string: posterBaseURL + profilePath)

            movieImageView.kf.setImage(with: url)
        } else {
            movieImageView.image = UIImage(systemName: "star")
        }
        
       

    }
    
}
