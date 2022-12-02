//
//  AppleRepoListViewController.swift
//  GitEmoji
//
//  Created by Wellington Bezerra on 11/30/22.
//

import UIKit

final class AppleRepoListViewController: UIViewController {

    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!
    
    private var presenter: AppleRepoListPresenterProtocol?
    
    private var repoList: [RepoViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Apple Repo List"
        self.setupTableView()
        self.activityIndicator.startAnimating()
        
        self.presenter?.viewDidLoad()
    }
    
    func setUp(presenter: AppleRepoListPresenterProtocol) {
        self.presenter = presenter
    }
    
    private func setupTableView() {
        self.tableView.registerNib(AppleRepoTableViewCell.self)

        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}


// MARK: - UITableViewDelegate, UITableViewDataSource

extension AppleRepoListViewController: UITableViewDelegate, UITableViewDataSource {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AppleRepoTableViewCell", for: indexPath) as? AppleRepoTableViewCell else { return UITableViewCell() }
        
        let repo = self.repoList[indexPath.row]
        cell.setUp(repoName: repo.name)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.repoList.count - 1 == indexPath.row {
            self.presenter?.willDisplayPenultimateItem()
        }
    }
}

extension AppleRepoListViewController: AppleRepoListPresenterDelegate {
    
    func show(repoList: [RepoViewModel]) {
        
        self.repoList += repoList
        
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }
    }
    
    func stopLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
    }
}
