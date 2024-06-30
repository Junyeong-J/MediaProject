//
//  DetailViewController.swift
//  MediaProject
//
//  Created by 전준영 on 6/11/24.
//

import UIKit
import Alamofire
import Kingfisher
import SnapKit
import Toast

class DetailViewController: UIViewController {
    
    var listData: TMDBResult? {
        didSet {
            callRequest()
        }
    }
    var castData: [CastMember] = []
    let overTableView = UITableView()
    
    let mainImageView = UIImageView()
    let titleLabel = UILabel()
    let posterImageVIew = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeNavigationUI()
        
        configureHierarchy()
        configureLayout()
        configureUI()
        configureTableView()
        configureData()
    }
    
    
}

extension DetailViewController {
    
    func makeNavigationUI() {
        navigationItem.title = "출연/제작"
        
        let similar = UIBarButtonItem(title: "관련된 영화", style: .plain, target: self, action: #selector(similarButtonClicked))
        navigationItem.rightBarButtonItem = similar
    }
    
    func configureHierarchy() {
        view.addSubview(mainImageView)
        mainImageView.addSubview(titleLabel)
        mainImageView.addSubview(posterImageVIew)
        
    }
    
    func configureLayout() {
        mainImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(200)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImageView).inset(20)
            make.leading.equalTo(mainImageView).inset(30)
        }
        
        posterImageVIew.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.bottom.equalTo(mainImageView).offset(-20)
            make.width.equalTo(80)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
        
        
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
        titleLabel.setUILabel("", textAlignment: .left, color: .white, backgroundColor: .clear, font: .boldSystemFont(ofSize: 22), cornerRadius: 0)
        
        
    }
    
    func configureTableView() {
        view.addSubview(overTableView)
        overTableView.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom)
            make.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        overTableView.dataSource = self
        overTableView.delegate = self

        overTableView.register(OverViewTableViewCell.self, forCellReuseIdentifier: OverViewTableViewCell.identifier)
        
        overTableView.register(CastTableViewCell.self, forCellReuseIdentifier: CastTableViewCell.identifier)
    }
    
    func callRequest() {
        guard let listData = listData else {return}
        let url = "\(APIURL.detailURL)\(listData.id)\(APIURL.secondDetailUrl)"
        AF.request(url)
            .responseDecodable(of: TMDBDetailResponse.self) { response in
                switch response.result {
                case .success(let value):
                    self.castData = value.cast
                    self.overTableView.reloadData()
                case .failure(let error):
                    self.view.makeToast(error.localizedDescription)
                }
            }
    }
    
    func configureData() {
        guard let listData = listData else {return}
        
        let posterBaseURL = APIURL.posterBaseURL
        let backdropURLString = posterBaseURL + listData.backdropPath
        let url = URL(string: backdropURLString)
        mainImageView.kf.setImage(with: url)
        
        titleLabel.text = listData.originalTitle
        
        let posterURLString = posterBaseURL + listData.posterPath
        let posterurl = URL(string: posterURLString)
        posterImageVIew.kf.setImage(with: posterurl)
    }
    
    @objc func similarButtonClicked() {
        guard let listData = listData else {return}
        let vc = RecommendMovieViewController()
        vc.id = listData.id
//        vc.naviTitle = listData.title!
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : castData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath[0] == 0 {
            
            return 80
        }else {
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: OverViewTableViewCell.identifier, for: indexPath) as! OverViewTableViewCell
            cell.configureData(data: listData)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.identifier, for: indexPath) as! CastTableViewCell
            cell.configureData(data: castData[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 20))
        headerView.backgroundColor = .white
        
        let titleLabel = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.frame.width, height: 30))
        titleLabel.textColor = .lightGray
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.textAlignment = .left
        
        if section == 0 {
            titleLabel.text = "OverView"
        } else {
            titleLabel.text = "Cast"
        }
        
        headerView.addSubview(titleLabel)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
}

