//
//  MediaViewController.swift
//  Movie
//
//  Created by 전준영 on 6/10/24.
//

import UIKit
import SnapKit
import Alamofire

class MediaViewController: UIViewController {
    
    let tableView = UITableView()
    var listData: [TMDBResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callRequest()
        configureTableView()
        
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
}

extension MediaViewController {
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = .blue
        
        tableView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 500
        tableView.register(MediaTableViewCell.self, forCellReuseIdentifier: MediaTableViewCell.identifier)
    }
    
    func configureHierarchy(){
        
    }
    
    func configureLayout(){
        
    }
    
    func configureUI(){
        view.backgroundColor = .white
    }
    
    func callRequest() {
        let url = APIURL.TMDBURL
        AF.request(url)
            .responseDecodable(of: TMDBResponse.self) { response in
                switch response.result {
                case .success(let value):
//                    print(value.results)
                    self.listData = value.results
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    
}

extension MediaViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(listData.count)
        return listData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MediaTableViewCell.identifier, for: indexPath) as! MediaTableViewCell
        cell.configureData(data: listData[indexPath.row])
        return cell
    }
    
}
