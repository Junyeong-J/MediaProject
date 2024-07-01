//
//  File.swift
//  MediaProject
//
//  Created by 전준영 on 7/1/24.
//

import UIKit
import WebKit
import SnapKit

final class DetailWebViewController: BaseViewController {
    
    var id: Int? {
        didSet {
            callRequest()
        }
    }
    private let webView = WKWebView()
    private let checkLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureHierarchy() {
        view.addSubview(webView)
        view.addSubview(checkLabel)
    }
    
    override func configureLayout() {
        webView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        checkLabel.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        view.backgroundColor = .white
        checkLabel.font = .systemFont(ofSize: 25)
    }
    
    func callRequest() {
        guard let id = self.id else { return }
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            
            TMDBManager.shared.trendingFetch(api: .moiveVideo(id: id), model: TMDBMovieVideo.self) { movie, error in
                if let error = error {
                    DispatchQueue.main.async {
                        self.view.makeToast(error.localizedDescription)
                    }
                } else {
                    guard let movie = movie else {return}
                    if let key = movie.results.first?.key, !key.isEmpty {
                        let url = URL(string: APIURL.VideoURL + key)!
                        let request = URLRequest(url: url)
                        DispatchQueue.main.async {
                            self.webView.load(request)
                        }
                    } else {
                        self.webView.isHidden = true
                        self.checkLabel.text = "이 영화는 찾는 링크가 없습니다."
                    }
                }
            }
            
            group.leave()
            
        }
        
        group.notify(queue: .main) {
            self.webView.reload()
        }
    }
    
}

