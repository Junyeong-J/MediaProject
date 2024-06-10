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
    
    let deviceWidth = UIScreen.main.bounds.size.width
    
    let tableView = UITableView()
    var listData: [TMDBResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callRequest()
        configureTableView()
        navigationUI()
        configureUI()
    }
    
}

extension MediaViewController {
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = deviceWidth
        tableView.register(MediaTableViewCell.self, forCellReuseIdentifier: MediaTableViewCell.identifier)
    }
    
    func navigationUI() {
        
        let left = UIBarButtonItem(image: UIImage(systemName: "list.bullet")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(listButtonClicked))
        left.tintColor = .black
        self.navigationItem.leftBarButtonItem = left
        
        let right = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(searchButtonClikced))
        right.tintColor = .black
        self.navigationItem.rightBarButtonItem = right
        
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
                    self.listData = value.results
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    @objc func listButtonClicked() {
        
        
    }
    
    
    @objc func searchButtonClikced() {
        
        
    }
    
    
}

extension MediaViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MediaTableViewCell.identifier, for: indexPath) as! MediaTableViewCell
        cell.configureData(data: listData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nv = DetailViewController()
        nv.listData = listData[indexPath.row]
        navigationController?.pushViewController(nv, animated: true)
    }
    
}
