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

protocol HomePresenterDelegate: AnyObject {
    func showRandomEmoji(imageURL: String)
}

final class HomePresenter: HomePresenterProtocol {
    
    private weak var delegate: HomePresenterDelegate?
    
    private var router: HomeRouter?
    private let interactor: HomeInteractorProtocol
    
    init(interactor: HomeInteractorProtocol = HomeInteractor()) {
        self.interactor = interactor
        self.interactor.setUp(delegate: self)
    }
    
    func set(router: HomeRouter) {
        self.router = router
    }
    
    func setUp(delegate: HomePresenterDelegate) {
        self.delegate = delegate
    }
    
    func didSelectRandomEmojiButton() {
        self.interactor.getRandomEmoji()
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

extension HomePresenter: HomeInteractorDelegate {
    
    func didGetRandomEmojiImage(url: String) {
        self.delegate?.showRandomEmoji(imageURL: url)
    }
}
