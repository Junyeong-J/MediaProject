//
//  MovieViewController.swift
//  MediaProject
//
//  Created by 전준영 on 6/11/24.
//

import UIKit
import SnapKit
import Alamofire
import Toast

final class MovieViewController: BaseViewController {
    
    private let searchBar = UISearchBar()
    
    private var list = Movie(page: 0, results: [], total_pages: 0, total_results: 0)
    private var page = 1
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    static private func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width - 40
        layout.itemSize = CGSize(width: width/2, height: width/2)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return layout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationUI()
        
        configureCollectionView()
        
        searchBar.delegate = self
    }
    
    override func configureHierarchy() {
        view.addSubview(searchBar)
    }
    
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.trailing.leading.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(searchBar.snp.bottom)
        }
    }
    
    override func configureView() {
        view.backgroundColor = .white
    }
    
}

extension MovieViewController {
    
    func configureCollectionView() {
        collectionView.backgroundColor = .white
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        
        collectionView.prefetchDataSource = self
        
    }
    
    func navigationUI() {
        navigationItem.title = "영화 검색"
    }
    
    func callRequest(query: String) {
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            
            TMDBManager.shared.trendingFetch(api: .searchMoive(query: query, page: self.page), model: Movie.self) { movie, error in
                if let error = error {
                    self.view.makeToast(error.localizedDescription)
                } else {
                    guard let movie = movie else {return}
                    if self.page == 1{
                        self.list = movie
                    } else {
                        self.list.results.append(contentsOf: movie.results)
                    }
                    self.collectionView.reloadData()
                    
                    if self.page == 1 && !self.list.results.isEmpty {
                        self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                    }
                }
            }
            
            group.leave()
            
        }
        
        group.notify(queue: .main) {
            self.collectionView.reloadData()
        }
    }
    
}

extension MovieViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as! MovieCollectionViewCell
        cell.configureData(data: list.results[indexPath.item])
        return cell
    }
}

extension MovieViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        page = 1
        callRequest(query: searchBar.text!)
    }
}

extension MovieViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for item in indexPaths {
            if list.results.count - 10 == item.item && page < list.total_pages{
                page += 1
                callRequest(query: searchBar.text!)
            }
        }
    }
}
