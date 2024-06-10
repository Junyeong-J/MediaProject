//
//  MovieTableViewCell.swift
//  Movie
//
//  Created by 전준영 on 6/7/24.
//

import UIKit
import SnapKit

class MovieTableViewCell: UITableViewCell {
    
    let rankLabel = UILabel()
    let movieDate = UILabel()
    let titleLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

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
        contentView.addSubview(rankLabel)
        contentView.addSubview(movieDate)
        contentView.addSubview(titleLabel)
    }
    
    func configureLayout() {
        rankLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.width.equalTo(35)
            make.height.equalTo(25)
            make.leading.equalTo(contentView).offset(20)
        }
        
        movieDate.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.trailing.equalTo(contentView).inset(15)
            make.width.equalTo(100)
            make.height.equalTo(25)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(rankLabel.snp.trailing).offset(20)
            make.trailing.equalTo(movieDate.snp.leading).offset(-20)
            make.height.equalTo(25)
        }
    }
    
    func configureUI() {
        
        rankLabel.setUILabel("0", textAlignment: .center, color: .black, backgroundColor: .white, font: .boldSystemFont(ofSize: 14), cornerRadius: 2)
        
        movieDate.setUILabel("0000-00-00", textAlignment: .right, color: .white, backgroundColor: .clear, font: .systemFont(ofSize: 12), cornerRadius: 0)
        
        titleLabel.setUILabel("제목", textAlignment: .left, color: .white, backgroundColor: .clear, font: .boldSystemFont(ofSize: 16), cornerRadius: 0)
    }
    
    func configureData(data: DailyBoxOfficeList) {
        rankLabel.text = data.rnum
        movieDate.text = data.openDt
        titleLabel.text = data.movieNm
    }
    
}
