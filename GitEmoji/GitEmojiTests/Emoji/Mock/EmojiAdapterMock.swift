//
//  EmojiAdapterMock.swift
//  GitEmojiTests
//
//  Created by Wellington on 05/12/22.
//

@testable import GitEmoji

final class EmojiAdapterMock: EmojiAdapterProtocol {
    
    var methods: [Method] = []
    var delegate: EmojiAdapterDelegate?
    var emojis: [String: String]?
    var isSuccess: Bool = true
    
    func fetchEmojiList() {
        self.methods.append(.fetchEmojiList)

        if let emojis = self.emojis, self.isSuccess {
            self.delegate?.didFetchEmojiList(emojiList: emojis)
        } else {
            self.delegate?.didNotFetchEmojiList()
        }
    }
    
    func setUp(delegate: GitEmoji.EmojiAdapterDelegate) {
        self.delegate = delegate
        self.methods.append(.setUpDelegate)
    }
    
    enum Method {
        case fetchEmojiList
        case setUpDelegate
    }
}
