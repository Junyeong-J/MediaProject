//
//  RecommendMovieViewController.swift
//  MediaProject
//
//  Created by 전준영 on 6/30/24.
//

import UIKit
import SnapKit

class RecommendMovieViewController: BaseViewController {
    
    var id: Int = 0
    let titles: [String] = ["비슷한영화", "추천영화"]
    var imageList: [[TMDBMovieData]] = [[TMDBMovieData(posterPath: "")],
                                        [TMDBMovieData(posterPath: "")]]
    
    lazy var tableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.rowHeight = 200
        view.register(RecommendTableViewCell.self, forCellReuseIdentifier: RecommendTableViewCell.identifier)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("aaaaa: \(id)")
        callRequest()
    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        view.backgroundColor = .white
    }
    
    
    
}

extension RecommendMovieViewController {
    
    func callRequest() {
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            
            TMDBManager.shared.trendingFetch(api: .similarMovie(id: self.id), model: RecommendResponse.self) { movie, error in
                if let error = error {
                    print(error)
                } else {
                    guard let movie = movie else {return}
                    self.imageList[0] = movie.results
                }
            }
            
            TMDBManager.shared.trendingFetch(api: .recommendMovie(id: self.id), model: RecommendResponse.self) { movie, error in
                if let error = error {
                    print(error)
                } else {
                    guard let movie = movie else {return}
                    self.imageList[1] = movie.results
                }
            }
            
//            TMDBManager.shared.trendingFetch(api: .moviePoster(id: self.id), model: RecommendResponse.self) { movie, error in
//                if let error = error {
//                    print(error)
//                } else {
//                    guard let movie = movie else {return}
//                    self.imageList[2] = movie.results
//                }
//            }
            
            group.leave()
            
        }
        
        group.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }
    
}

extension RecommendMovieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecommendTableViewCell.identifier, for: indexPath) as! RecommendTableViewCell
        cell.configureData(title: titles[indexPath.row])
        cell.collectionView.dataSource = self
        cell.collectionView.delegate = self
        cell.collectionView.tag = indexPath.row
        cell.collectionView.register(RecommendCollectionViewCell.self, forCellWithReuseIdentifier: RecommendCollectionViewCell.identifier)
        cell.collectionView.reloadData()
        return cell
    }
}

extension RecommendMovieViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendCollectionViewCell.identifier, for: indexPath) as! RecommendCollectionViewCell
        let data = imageList[collectionView.tag][indexPath.item]
        let url = URL(string: "\(APIURL.posterBaseURL)\(data.posterPath ?? "")")
        cell.configureData(data: url)
        return cell
    }
}
