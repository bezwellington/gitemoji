//
//  EmojiListPresenter.swift
//  GitEmoji
//
//  Created by Wellington on 04/12/22.
//

// MARK: - Protocol

protocol EmojiListPresenterProtocol {
    func setUp(delegate: EmojiListPresenterDelegate)
    func setUp(listType: EmojiListPresenter.ListType)
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
    private var listType: ListType = .none

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
    
    func setUp(listType: EmojiListPresenter.ListType) {
        self.listType = listType
    }

    func viewDidLoad() {
        if self.listType == .emoji {
            self.interactor.fetchEmojiList()
        } else {
            self.interactor.fetchAvatarList()
        }
    }
    
    func didSelect(emojiViewModel: EmojiViewModel) {
        if self.listType == .emoji {
            if let index = self.filteredEmojiList.firstIndex(where: {$0.id == emojiViewModel.id}) {
                self.filteredEmojiList.remove(at: index)
            }
            
            self.delegate?.show(emojiList: self.filteredEmojiList)
        } else {
            if let index = self.emojiList.firstIndex(where: {$0.id == emojiViewModel.id}) {
                self.emojiList.remove(at: index)
            }
            
            self.delegate?.show(emojiList: self.emojiList)
            
            self.interactor.removeAvatar(avatarID: emojiViewModel.id)
        }

    }
    
    func didRefresh() {
        self.delegate?.show(emojiList: self.emojiList)
        
        self.delegate?.endRefreshing()
    }
}


// MARK: - EmojiListInteractorDelegate

extension EmojiListPresenter: EmojiListInteractorDelegate {
    
    func didFetchList(list: [String : String]) {
        let emojiListViewModel = EmojiViewModelMapper.make(emojiList: list)
        
        self.emojiList = emojiListViewModel
        self.filteredEmojiList = emojiListViewModel
        
        self.delegate?.show(emojiList: emojiListViewModel)
    }
    
    func didNotFetchList() {
        self.delegate?.stopLoading()
    }
}


extension EmojiListPresenter {
    
    enum ListType {
        case emoji
        case avatar
        case none
    }
}
