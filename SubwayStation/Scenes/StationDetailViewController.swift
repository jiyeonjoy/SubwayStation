//
//  StationDetailViewController.swift
//  SubwayStation
//
//  Created by Jiyeon Choi on 2023. 1. 10..
//

import Alamofire
import SnapKit
import UIKit

final class StationDetailViewController: UIViewController {
//    private let station: Station
    private var realtimeArrivalList: [StationArrivalDatResponseModel.RealTimeArrival] = []
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)

        return refreshControl
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(
            width: view.frame.width - 32.0,
            height: 100.0
        )
        layout.sectionInset = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(StationDetailCollectionViewCell.self, forCellWithReuseIdentifier: "StationDetailCollectionViewCell")

        collectionView.dataSource = self

        collectionView.refreshControl = refreshControl

        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "왕십리역"
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
        fetchData()
    }

    @objc private func fetchData() {
        let stationName = "왕십리역"
        let urlString = "http://swopenapi.seoul.go.kr/api/subway/sample/json/realtimeStationArrival/0/5/\(stationName.replacingOccurrences(of: "역", with: ""))"

        AF
            .request(urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
            .responseDecodable(of: StationArrivalDatResponseModel.self) { [weak self] response in
                self?.refreshControl.endRefreshing()

                guard case .success(let data) = response.result else { return }
                print(data)
                self?.realtimeArrivalList = data.realtimeArrivalList
                self?.collectionView.reloadData()
            }
            .resume()
    }
}

extension StationDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "StationDetailCollectionViewCell",
            for: indexPath
        ) as? StationDetailCollectionViewCell
        
        cell?.setup()
        
        return cell ?? UICollectionViewCell()
    }
}
