//
//  HomePresenter.swift
//  GitEmoji
//
//  Created by Wellington Bezerra on 11/30/22.
//


// MARK: - Protocol

protocol HomePresenterProtocol {
    func set(router: HomeRouter)
    func didSelectRandomEmojiButton()
    func didSelectEmojiListButton()
    func didSelectAvatarListButton()
    func didSelectAppleReposButton()
    func didSelectSearchButton()
    func didSelectFetchEmojiButton()
}


final class HomePresenter: HomePresenterProtocol {
    

    private var router: HomeRouter?
    private let interactor: HomeInteractorProtocol
    
    init(interactor: HomeInteractorProtocol = HomeInteractor()) {
        self.interactor = interactor
    }
    
    func set(router: HomeRouter) {
        self.router = router
    }
    
    func didSelectRandomEmojiButton() {
        self.router?.openRandomEmojiViewController()
    }
    
    func didSelectEmojiListButton() {
        self.router?.openEmojiListViewController()
    }
    
    func didSelectAvatarListButton() {
        self.router?.openAvatarListViewController()
    }
    
    func didSelectAppleReposButton() {
        self.router?.openAppleReposViewController()
    }
    
    func didSelectSearchButton() {
        self.router?.openSearchViewController()
    }
    
    func didSelectFetchEmojiButton() {
        self.interactor.fetchEmojiList()
    }
}

