//
//  AppleRepoInteractor.swift
//  GitEmoji
//
//  Created by Wellington Bezerra on 12/1/22.
//


// MARK: - Protocol

protocol AppleRepoListInteractorProtocol {
    func setUp(delegate: AppleRepoListInteractorDelegate)
    func fetchAppleRepoList()
    func fetchPaginate()
}


// MARK: - Delegate

protocol AppleRepoListInteractorDelegate: AnyObject {
    func didFetchRepoList(repoList: [Repo])
    func didNotFetchRepoList()
}

// MARK: - Class

final class AppleRepoListInteractor {
    
    private weak var delegate: AppleRepoListInteractorDelegate?
    
    private let adapter: AppleRepoListAdapterProtocol
    private let storage: RepoStorageProtocol
    
    private var page: Int = 1
    private var isActivatedCache: Bool = false
    
    init(adapter: AppleRepoListAdapterProtocol = AppleRepoListAdapter(),
         storage: RepoStorageProtocol = RepoStorage()) {
        
        self.adapter = adapter
        self.storage = storage
        
        self.adapter.setUp(delegate: self)
    }
}


// MARK: - AppleRepoListAdapterProtocol

extension AppleRepoListInteractor: AppleRepoListInteractorProtocol {
    
    func setUp(delegate: AppleRepoListInteractorDelegate) {
        self.delegate = delegate
    }
    
    func fetchAppleRepoList() {
        guard !self.isActivatedCache else { return }
        
        self.adapter.fetchAppleRepoList(page: self.page)
    }
    
    func fetchPaginate() {
        guard !self.isActivatedCache else { return }

        self.page += 1
        self.adapter.fetchAppleRepoList(page: self.page)
    }
}


// MARK: - AppleRepoListAdapterDelegate

extension AppleRepoListInteractor: AppleRepoListAdapterDelegate {
    
    func didFetchRepoList(repoList: [Repo]) {
        self.storage.save(repoList: repoList)
        
        self.delegate?.didFetchRepoList(repoList: repoList)
    }
    
    func didNotFetchRepoList() {
        if let repoList = self.storage.getRepoList() {
            self.isActivatedCache = true
            self.delegate?.didFetchRepoList(repoList: repoList)
        } else {
            self.delegate?.didNotFetchRepoList()
        }
    }
}
