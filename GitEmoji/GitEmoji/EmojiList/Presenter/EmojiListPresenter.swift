//
//  EmojiListPresenter.swift
//  GitEmoji
//
//  Created by Wellington on 04/12/22.
//

// MARK: - Protocol

protocol EmojiListPresenterProtocol {
    func setUp(delegate: EmojiListPresenterDelegate)
    func set(router: EmojiListRouter)
    func viewDidLoad()
    func didSelect(emojiViewModel: EmojiViewModel)
    func didRefresh()
}


// MARK: - Delegate

protocol EmojiListPresenterDelegate: AnyObject {
    func show(emojiList: [EmojiViewModel])
    func stopLoading()
    func endRefreshing()
}


// MARK: - Class

final class EmojiListPresenter {
    
    private weak var delegate: EmojiListPresenterDelegate?

    private let interactor: EmojiListInteractorProtocol
    private var router: EmojiListRouter?
    
    private var emojiList: [EmojiViewModel] = []
    private var filteredEmojiList: [EmojiViewModel] = []

    init(interactor: EmojiListInteractorProtocol = EmojiListInteractor()) {
        self.interactor = interactor
        self.interactor.setUp(delegate: self)
    }
}


// MARK: - EmojiListPresenterProtocol

extension EmojiListPresenter: EmojiListPresenterProtocol {

    func set(router: EmojiListRouter) {
        self.router = router
    }
    
    func setUp(delegate: EmojiListPresenterDelegate) {
        self.delegate = delegate
    }
    
    func viewDidLoad() {
        self.interactor.fetchEmojiList()
    }
    
    func didSelect(emojiViewModel: EmojiViewModel) {
        if let index = self.filteredEmojiList.firstIndex(where: {$0.id == emojiViewModel.id}) {
            self.filteredEmojiList.remove(at: index)
        }
        
        self.delegate?.show(emojiList: self.filteredEmojiList)
    }
    
    func didRefresh() {
        self.delegate?.show(emojiList: self.emojiList)
        
        self.delegate?.endRefreshing()
    }
}


// MARK: - EmojiListInteractorDelegate

extension EmojiListPresenter: EmojiListInteractorDelegate {
    
    func didFetchRepoList(emojiList: [String : String]) {
        let emojiListViewModel = EmojiViewModelMapper.make(emojiList: emojiList)
        
        self.emojiList = emojiListViewModel
        self.filteredEmojiList = emojiListViewModel
        
        self.delegate?.show(emojiList: emojiListViewModel)
    }
    
    func didNotFetchRepoList() {
        self.delegate?.stopLoading()
    }
}
