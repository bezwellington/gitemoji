//
//  AppleRepoPresenter.swift
//  GitEmoji
//
//  Created by Wellington Bezerra on 12/1/22.
//


// MARK: - Protocol

protocol AppleRepoListPresenterProtocol {
    func setUp(delegate: AppleRepoListPresenterDelegate)
    func set(router: AppleRepoListRouter)
    func viewDidLoad()
    func willDisplayPenultimateItem()
}


// MARK: - Delegate

protocol AppleRepoListPresenterDelegate: AnyObject {
    func show(repoList: [RepoViewModel])
    func stopLoading()
}


// MARK: - Class

final class AppleRepoListPresenter {
    
    private weak var delegate: AppleRepoListPresenterDelegate?

    private let interactor: AppleRepoListInteractorProtocol
    private var router: AppleRepoListRouter?
    
    init(interactor: AppleRepoListInteractorProtocol = AppleRepoListInteractor()) {
        self.interactor = interactor
        self.interactor.setUp(delegate: self)
    }
}


// MARK: - AppleRepoListPresenterProtocol

extension AppleRepoListPresenter: AppleRepoListPresenterProtocol {
    
    func set(router: AppleRepoListRouter) {
        self.router = router
    }
    
    func setUp(delegate: AppleRepoListPresenterDelegate) {
        self.delegate = delegate
    }
    
    func viewDidLoad() {
        self.interactor.fetchAppleRepoList()
    }
    
    func willDisplayPenultimateItem() {
        self.interactor.fetchPaginate()
    }
}


// MARK: - AppleRepoListInteractorDelegate

extension AppleRepoListPresenter: AppleRepoListInteractorDelegate {
    
    func didFetchRepoList(repoList: [Repo]) {
        let repoListViewModel = RepoViewModelMapper.make(repoList: repoList)
        self.delegate?.show(repoList: repoListViewModel)
    }
    
    func didNotFetchRepoList() {
        self.delegate?.stopLoading()
    }
}
