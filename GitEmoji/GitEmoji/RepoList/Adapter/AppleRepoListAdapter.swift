//
//  AppleRepoAdapter.swift
//  GitEmoji
//
//  Created by Wellington Bezerra on 12/1/22.
//

import Foundation


// MARK: - Protocol

protocol AppleRepoListAdapterProtocol {
    func fetchAppleRepoList(page: Int)
    func setUp(delegate: AppleRepoListAdapterDelegate)
}


// MARK: - Delegate

protocol AppleRepoListAdapterDelegate: AnyObject {
    func didFetchRepoList(repoList: [Repo])
    func didNotFetchRepoList()
}


// MARK: - Class

final class AppleRepoListAdapter {
    
    private weak var delegate: AppleRepoListAdapterDelegate?
    
    private let urlString = "https://api.github.com/users/apple/repos"
}


// MARK: - AppleRepoListAdapterProtocol

extension AppleRepoListAdapter: AppleRepoListAdapterProtocol {
    
    func setUp(delegate: AppleRepoListAdapterDelegate) {
        self.delegate = delegate
    }
    
    func fetchAppleRepoList(page: Int) {
                
        let queryItems = [URLQueryItem(name: "page", value: "\(page)"),
                          URLQueryItem(name: "per_page", value: "10")]
        
        var urlComps = URLComponents(string: "https://api.github.com/users/apple/repos")
        urlComps?.queryItems = queryItems
        
        guard let url = urlComps?.url else { return }

        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            
            guard error == nil else {
                self?.delegate?.didNotFetchRepoList()
                return
            }
            
            guard let data = data, let repoList = try? JSONDecoder().decode([Repo].self, from: data) else {
                self?.delegate?.didNotFetchRepoList()
                return
            }
            self?.delegate?.didFetchRepoList(repoList: repoList)
        }
        
        task.resume()
    }
}
