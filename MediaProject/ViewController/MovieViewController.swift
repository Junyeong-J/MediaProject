//
//  MovieViewController.swift
//  MediaProject
//
//  Created by 전준영 on 6/11/24.
//

import UIKit
import SnapKit
import Alamofire

class MovieViewController: UIViewController {
    
    let searchBar = UISearchBar()
    
    var list = Movie(page: 0, results: [], total_pages: 0)
    var page = 1
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    static func collectionViewLayout() -> UICollectionViewLayout {
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
        configureHierarchy()
        configureLayout()
        configureUI()
        
        searchBar.delegate = self
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
    
    func configureHierarchy() {
        view.addSubview(searchBar)
        
        
    }
    
    func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.trailing.leading.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(searchBar.snp.bottom)
        }
    }
    
    func configureUI() {
        view.backgroundColor = .white
    }
    
    func navigationUI() {
        navigationItem.title = "영화 검색"
    }
    
    func callRequset(query: String) {
        let url = APIURL.TMDBMovieURL
        let params = [
            "query" : query,
            "language" : "ko",
            "page" : page
        ] as [String : Any]
        let header: HTTPHeaders = ["Authorization": APIKey.TMDBAuthorization]
        AF.request(url, parameters: params, headers: header).responseDecodable(of: Movie.self) { response in
            switch response.result{
            case .success(let value):
                if self.page == 1{
                    self.list = value
                } else {
                    self.list.results.append(contentsOf: value.results)
                }
                self.collectionView.reloadData()
                
                if self.page == 1 && !self.list.results.isEmpty {
                    self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                }
            case .failure(let error):
                print(error)
            }
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
        callRequset(query: searchBar.text!)
    }
}

extension MovieViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for item in indexPaths {
            if list.results.count - 10 == item.item && list.page < list.total_pages{
                page += 1
                callRequset(query: searchBar.text!)
            }
        }
    }
}
