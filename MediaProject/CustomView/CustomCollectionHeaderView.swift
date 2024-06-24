//
//  CustomCollectionHeaderView.swift
//  MediaProject
//
//  Created by 전준영 on 6/25/24.
//

import UIKit
import SnapKit

class CustomCollectionHeaderView: UICollectionReusableView {
//    static let identifier = "CustomCollectionHeaderView"
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()
    
    func configure() {
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.snp.makeConstraints { make in
            make.leading.centerY.equalTo(safeAreaLayoutGuide)
        }
    }
    
    func configureData(title: String) {
        label.text = title
    }
}
