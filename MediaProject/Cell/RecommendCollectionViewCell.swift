//
//  RecommendCollectionViewCell.swift
//  MediaProject
//
//  Created by 전준영 on 6/24/24.
//

import UIKit
import Kingfisher

class RecommendCollectionViewCell: UICollectionViewCell {
    
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
    
    
    func configureSimilarData(data: TMDBMovie) {
        
        let posterBaseURL = APIURL.posterBaseURL
        if let profilePath = data.posterPath{
            let url = URL(string: posterBaseURL + profilePath)

            movieImageView.kf.setImage(with: url)
        } else {
            movieImageView.image = UIImage(systemName: "star")
        }

    }
    
    func configureRecommendData(data: TMDBMovieData) {
        
        let posterBaseURL = APIURL.posterBaseURL
        if let profilePath = data.posterPath{
            let url = URL(string: posterBaseURL + profilePath)

            movieImageView.kf.setImage(with: url)
        } else {
            movieImageView.image = UIImage(systemName: "star")
        }

    }
    
}
