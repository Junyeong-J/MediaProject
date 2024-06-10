//
//  MediaTableViewCell.swift
//  Movie
//
//  Created by 전준영 on 6/10/24.
//

import UIKit
import SnapKit
import Kingfisher

class MediaTableViewCell: UITableViewCell {
    
    let deviceWidth = UIScreen.main.bounds.size.width
    
    let dateLabel = UILabel()
    let genreLabel = UILabel()
    let posterView = UIView()
    let posterImageView = UIImageView()
    let titleLabel = UILabel()
    let subTitleLabel = UILabel()
    let lineView = UIView()
    let detailLabel = UILabel()
    let arrowImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureLayout()
        configureUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(genreLabel)
        
        contentView.addSubview(posterView)
        posterView.addSubview(posterImageView)
        posterView.addSubview(titleLabel)
        posterView.addSubview(subTitleLabel)
        posterView.addSubview(detailLabel)
        posterView.addSubview(arrowImageView)
        posterView.addSubview(lineView)
        
    }
    
    func configureLayout() {
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(10)
            make.leading.equalTo(contentView).inset(20)
            make.width.equalTo(100)
        }
        
        genreLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(2)
            make.leading.equalTo(dateLabel)
            make.width.equalTo(150)
        }
        
        posterView.snp.makeConstraints { make in
            make.size.equalTo(deviceWidth - 40)
            make.top.equalTo(genreLabel.snp.bottom).offset(5)
            make.leading.equalTo(contentView).inset(20)
        }
        
        posterImageView.snp.makeConstraints { make in
            make.height.equalTo((deviceWidth - 40) * 0.6)
            make.top.leading.trailing.equalTo(posterView)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(10)
            make.leading.trailing.equalTo(posterView).inset(20)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(posterView).inset(20)
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
        }
        
        detailLabel.snp.makeConstraints { make in
            make.bottom.equalTo(posterView).inset(10)
            make.width.equalTo(100)
            make.leading.equalTo(posterView).inset(20)
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.bottom.equalTo(posterView).inset(10)
            make.size.equalTo(30)
            make.trailing.equalTo(posterView).inset(20)
        }
        
        lineView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(posterView).inset(20)
            make.height.equalTo(1)
            make.bottom.equalTo(arrowImageView.snp.top).offset(-5)
        }
    }
    
    func configureUI() {
        dateLabel.setUILabel("", textAlignment: .left, color: .darkGray, backgroundColor: .clear, font: .systemFont(ofSize: 13), cornerRadius: 0)
        
        genreLabel.backgroundColor = .blue
        
        posterView.backgroundColor = .cyan
        
        posterImageView.setImageViewUI(contentMode: .scaleToFill, cornerRadius: 10)
        
        titleLabel.setUILabel("", textAlignment: .left, color: .black, backgroundColor: .clear, font: .boldSystemFont(ofSize: 17), cornerRadius: 0)
        
        subTitleLabel.setUILabel("", textAlignment: .left, color: .darkGray, backgroundColor: .clear, font: .systemFont(ofSize: 14), cornerRadius: 0)
        
        lineView.backgroundColor = .black
        
        detailLabel.backgroundColor = .green
        
        arrowImageView.backgroundColor = .blue
    }
    
    func configureData(data: TMDBResult) {
        
        dateLabel.text = data.releaseDate
        
        let posterBaseURL = APIURL.posterBaseURL
        let posterURLString = posterBaseURL + data.posterPath
        let url = URL(string: posterURLString)
        posterImageView.kf.setImage(with: url)
        
        titleLabel.text = data.originalTitle
        
        subTitleLabel.text = data.overview
        
    }

}
