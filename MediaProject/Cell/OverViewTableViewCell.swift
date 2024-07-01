//
//  OverViewTableViewCell.swift
//  MediaProject
//
//  Created by 전준영 on 6/11/24.
//

import UIKit
import SnapKit

final class OverViewTableViewCell: UITableViewCell {
    
    private let overViewText = UILabel()
    private let moreButton = UIButton()
    private var height: Int?
    
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
        contentView.addSubview(overViewText)
        contentView.addSubview(moreButton)
    }
    
    func configureLayout() {
        overViewText.snp.makeConstraints { make in
            make.leading.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(30)
            make.top.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
        
        moreButton.snp.makeConstraints { make in
            make.centerX.equalTo(overViewText)
            make.size.equalTo(44)
            make.top.equalTo(overViewText.snp.bottom).offset(5)
        }
    }
    
    func configureUI(){
        overViewText.setUILabel("", textAlignment: .left, color: .black, backgroundColor: .clear, font: .systemFont(ofSize: 14), cornerRadius: 0)
        overViewText.numberOfLines = 2
        
        moreButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        moreButton.tintColor = .black
        moreButton.backgroundColor = .clear
        moreButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
    }
    
    func configureData(data: TMDBResult?) {
        overViewText.text = data?.overview
    }
    
    @objc func moreButtonTapped() {
        if overViewText.numberOfLines == 2 {
            overViewText.numberOfLines = 0
            moreButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        } else {
            overViewText.numberOfLines = 2
            moreButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)

        }
        contentView.layoutIfNeeded()
    }
    
}
