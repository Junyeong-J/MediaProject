//
//  RecommendViewController.swift
//  MediaProject
//
//  Created by 전준영 on 6/24/24.
//

import UIKit
import SnapKit

class RecommendViewController: UIViewController {
    
    var similarData: SimilarResponse = SimilarResponse(page: 0, results: [TMDBMovie(posterPath: "")], totalPages: 0, totalResults: 0)
    var recommendData: RecommendResponse = RecommendResponse(page: 0, results: [TMDBMovieData(posterPath: "")], totalPages: 0, totalResults: 0)
    var naviTitle = ""
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let sectionSpacing: CGFloat = 20
        let cellSpacing: CGFloat = 5
        let width = UIScreen.main.bounds.width - (sectionSpacing * 2) - (cellSpacing * 3)
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(width/3), heightDimension: .absolute(width/3 * 1.5))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(width), heightDimension: .estimated(width/3 * 1.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(cellSpacing)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = cellSpacing
        section.contentInsets = NSDirectionalEdgeInsets(top: sectionSpacing, leading: sectionSpacing, bottom: sectionSpacing, trailing: sectionSpacing)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(30))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    var id: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = naviTitle
        
        configureHierarchy()
        configureLayout()
        configureUI()
        
        configureCollectionView()
        
        callSimilarRequest(id: id)
        callRecommendRequest(id: id)
    }
    
    
    
}

extension RecommendViewController {
    
    func configureHierarchy() {
        view.addSubview(collectionView)
    }
    
    func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureUI() {
        view.backgroundColor = .white
    }
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(RecommendCollectionViewCell.self, forCellWithReuseIdentifier: RecommendCollectionViewCell.identifier)
        collectionView.register(CustomCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CustomCollectionHeaderView.identifier)
    }
    
    func callSimilarRequest(id: Int) {
        DispatchQueue.global().async{
            TMDBManager.shared.getTMDBSimilar(id: id) { result in
                DispatchQueue.main.async{
                    switch result {
                    case .success(let value):
                        self.similarData = value
                        self.collectionView.reloadData()
                    case .failure(_):
                        self.view.makeToast("네트워크 에러입니다. 잠시후 다시 사용해 주세요.")
                    }
                }
            }
        }
    }
    
    func callRecommendRequest(id: Int) {
        DispatchQueue.global().async{
            TMDBManager.shared.getTMDBRecommend(id: id) { result in
                DispatchQueue.main.async{
                    switch result {
                    case .success(let value):
                        self.recommendData = value
                        self.collectionView.reloadData()
                    case .failure(_):
                        self.view.makeToast("네트워크 에러입니다. 잠시후 다시 사용해 주세요.")
                    }
                }
            }
        }
    }
    
}

extension RecommendViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CustomCollectionHeaderView.identifier, for: indexPath) as? CustomCollectionHeaderView else {
                return CustomCollectionHeaderView()
            }
            header.configure()
            if indexPath.section == 0 {
                header.configureData(title: "비슷한 영화")
            } else {
                header.configureData(title: "추천 영화")
            }
            return header
        }
        return CustomCollectionHeaderView()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return similarData.results.count
        } else {
            return recommendData.results.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendCollectionViewCell.identifier, for: indexPath) as! RecommendCollectionViewCell
        if indexPath.section == 0 {
            cell.configureSimilarData(data: similarData.results[indexPath.item])
        } else {
            cell.configureRecommendData(data: recommendData.results[indexPath.item])
        }
        
        return cell
    }
    
    
}
