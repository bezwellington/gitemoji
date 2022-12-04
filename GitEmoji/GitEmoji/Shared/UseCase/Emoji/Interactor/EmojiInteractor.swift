//
//  EmojiInteractor.swift
//  GitEmoji
//
//  Created by Wellington on 03/12/22.
//

protocol EmojiInteractorProtocol {
    func setUp(delegate: EmojiInteractorDelegate)
    func fetchEmojiList()
}

protocol EmojiInteractorDelegate: AnyObject {
    func didFetchEmojiList(emojiList: [String : String])
    func didNotFetchEmojiList()
}

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

extension EmojiInteractor: EmojiInteractorProtocol {
    
    func fetchEmojiList() {
        if let emojiList = self.storage.getEmojiList() {
            self.delegate?.didFetchEmojiList(emojiList: emojiList)
        } else {
            self.adapter.fetchEmojiList()
        }
    }
}

extension EmojiInteractor: EmojiAdapterDelegate {
    
    func didFetchEmojiList(emojiList: [String : String]) {
        self.storage.save(emojiList: emojiList)
        
        self.delegate?.didFetchEmojiList(emojiList: emojiList)
    }
    
    func didNotFetchEmojiList() {
        self.delegate?.didNotFetchEmojiList()
    }
}