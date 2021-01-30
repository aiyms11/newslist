//
//  MainPage.swift
//  newsListApp
//
//  Created by Aiymgul Sarsenbayeva on 1/29/21.
//

import Foundation
import UIKit

final class MainPage: UIViewController, AlertPresentable, LoadingViewable {
    var activityIndicator = UIActivityIndicatorView()
    
    private var viewModel = MainViewModel()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(NewsCell.self, forCellReuseIdentifier: "NewsCell")
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News"
        tableView.estimatedRowHeight = 200
        layoutUI()
        bindViewModel()
        viewModel.getNews()
    }
    
    private func layoutUI() {
        view.backgroundColor = UIColor(named: "backGroundColor")
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            tableView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height),
            tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func bindViewModel() {
        viewModel.didStartRequest = { [weak self] in
            self?.showLoader()
        }
        viewModel.didEndRequest = { [weak self] in
            self?.hideLoader()
        }
        viewModel.didSucessLoadNews = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        viewModel.showErrorAlert = { [weak self] error in
            self?.showErrorAlert(error)
        }
    }
}

extension MainPage: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        cell.configure(data: viewModel.news[indexPath.row])
        return cell
    }
}

extension MainPage: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let page = NewsDetailPage(news: viewModel.news[indexPath.row])
        navigationController?.pushViewController(page, animated: true)
    }
}
