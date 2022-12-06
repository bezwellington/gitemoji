//
//  EmojiInteractor.swift
//  GitEmoji
//
//  Created by Wellington on 03/12/22.
//


// MARK: - Protocol

protocol EmojiInteractorProtocol {
    func setUp(delegate: EmojiInteractorDelegate)
    func fetchEmojiList()
    func fetchEmojiListFromCache() -> [String: String]?
    func getRandomEmojiImageURL()
}


// MARK: - Delegate

protocol EmojiInteractorDelegate: AnyObject {
    func didFetchEmojiList(emojiList: [String : String], isCached: Bool)
    func didNotFetchEmojiList()
    
    func didGetRandomEmojiImage(url: String?)
}


// MARK: - Class

final class EmojiInteractor {
    
    private weak var delegate: EmojiInteractorDelegate?
    
    private let adapter: EmojiAdapterProtocol
    private let storage: EmojiStorageProtocol
    
    init(adapter: EmojiAdapterProtocol = EmojiAdapter(),
         storage: EmojiStorageProtocol = EmojiStorage()) {
        
        self.adapter = adapter
        self.storage = storage
        
        self.adapter.setUp(delegate: self)
    }
    
    func setUp(delegate: EmojiInteractorDelegate) {
        self.delegate = delegate
    }
}


// MARK: - EmojiInteractorProtocol

extension EmojiInteractor: EmojiInteractorProtocol {
    
    func fetchEmojiList() {
        if let emojiList = self.storage.getEmojiList() {
            self.delegate?.didFetchEmojiList(emojiList: emojiList, isCached: true)
        } else {
            self.adapter.fetchEmojiList()
        }
    }
    
    func fetchEmojiListFromCache() -> [String: String]? {
        let emojiList = self.storage.getEmojiList()
        return emojiList
    }

    func getRandomEmojiImageURL() {
        let emojiList = self.storage.getEmojiList()
        let randomEmojiImageURL = emojiList?.values.randomElement()
        self.delegate?.didGetRandomEmojiImage(url: randomEmojiImageURL)
    }
}


// MARK: - EmojiAdapterDelegate

extension EmojiInteractor: EmojiAdapterDelegate {
    
    func didFetchEmojiList(emojiList: [String : String]) {
        self.storage.save(emojiList: emojiList)
        
        self.delegate?.didFetchEmojiList(emojiList: emojiList, isCached: false)
    }
    
    func didNotFetchEmojiList() {
        self.delegate?.didNotFetchEmojiList()
    }
}
