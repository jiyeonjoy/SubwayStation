//
//  StationSearchViewController.swift
//  SubwayStation
//
//  Created by Jiyeon Choi on 2022. 12. 7..
//

import SnapKit
import UIKit

class StationSearchViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItems()
    }
    
    private func setNavigationItems() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "지하철 도착 정보"

        let searchController = UISearchController()
        searchController.searchBar.placeholder = "지하철 역을 입력해주세요."
        searchController.obscuresBackgroundDuringPresentation = false

        navigationItem.searchController = searchController
    }
}
