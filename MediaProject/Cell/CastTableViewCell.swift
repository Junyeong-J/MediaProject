//
//  CastTableViewCell.swift
//  MediaProject
//
//  Created by 전준영 on 6/11/24.
//

import UIKit
import Kingfisher
import SnapKit

final class CastTableViewCell: UITableViewCell {
    
    private let castImageView = UIImageView()
    private let nameLabel = UILabel()
    private let characterLabel = UILabel()
    
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
        contentView.addSubview(castImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(characterLabel)
    }
    
    func configureLayout() {
        castImageView.snp.makeConstraints { make in
            make.width.equalTo(70)
            make.height.equalTo(90)
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView).inset(20)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(castImageView.snp.trailing).offset(20)
            make.bottom.equalTo(contentView.snp.centerY).offset(-5)
        }
        
        characterLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.centerY).offset(5)
            make.leading.equalTo(castImageView.snp.trailing).offset(20)
        }
    }
    
    func configureUI() {
        
        castImageView.setImageViewUI(contentMode: .scaleToFill, cornerRadius: 10)
        castImageView.layer.masksToBounds = true
        
        nameLabel.setUILabel("", textAlignment: .left, color: .black, backgroundColor: .clear, font: .systemFont(ofSize: 18), cornerRadius: 0)
        characterLabel.setUILabel("", textAlignment: .left, color: .lightGray, backgroundColor: .clear, font: .systemFont(ofSize: 15), cornerRadius: 0)
    }
    
    func configureData(data: CastMember){
        
        let posterBaseURL = APIURL.posterBaseURL
        if let profilePath = data.profilePath,
           let url = URL(string: posterBaseURL + profilePath) {
            castImageView.kf.setImage(with: url)
        } else {
            castImageView.image = UIImage(systemName: "star")
        }
        
        nameLabel.text = data.name
        
        characterLabel.text = data.character
    }
    
}
