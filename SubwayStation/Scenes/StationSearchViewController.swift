//
//  StationSearchViewController.swift
//  SubwayStation
//
//  Created by Jiyeon Choi on 2022. 12. 7..
//

import SnapKit
import UIKit

class StationSearchViewController: UIViewController {
    
    var numberOfCell = 0
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isHidden = true

        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationItems()
        setTableViewLayout()
    }
    
    private func setNavigationItems() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "지하철 도착 정보"

        let searchController = UISearchController()
        searchController.searchBar.placeholder = "지하철 역을 입력해주세요."
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        
        navigationItem.searchController = searchController
    }
    
    private func setTableViewLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}

extension StationSearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        numberOfCell = 10
        tableView.reloadData()
        tableView.isHidden = false
        
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        numberOfCell = 0
        tableView.isHidden = true
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }
}

extension StationSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = StationDetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension StationSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfCell
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.text = "왕십리역"
        cell.detailTextLabel?.text = "디테일텍스트"

        return cell
    }
}
