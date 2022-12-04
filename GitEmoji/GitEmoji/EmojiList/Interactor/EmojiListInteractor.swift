//
//  EmojiListInteractor.swift
//  GitEmoji
//
//  Created by Wellington on 04/12/22.
//

// MARK: - Protocol

protocol EmojiListInteractorProtocol {
    func setUp(delegate: EmojiListInteractorDelegate)
    func fetchEmojiList()
    func fetchPaginate()
}


// MARK: - Delegate

protocol EmojiListInteractorDelegate: AnyObject {
    func didFetchRepoList(emojiList: [String: String])
    func didNotFetchRepoList()
}

// MARK: - Class

final class EmojiListInteractor {
    
    private weak var delegate: EmojiListInteractorDelegate?
    
    private let storage: EmojiStorageProtocol
    
    init(storage: EmojiStorageProtocol = EmojiStorage()) {
        self.storage = storage
    }
}


// MARK: - EmojiListAdapterProtocol

extension EmojiListInteractor: EmojiListInteractorProtocol {
    
    func setUp(delegate: EmojiListInteractorDelegate) {
        self.delegate = delegate
    }
    
    func fetchEmojiList() {
        let emojiList = self.storage.getEmojiList() ?? [:]
        self.delegate?.didFetchRepoList(emojiList: emojiList)
    }
    
    func fetchPaginate() {}
}
