//
//  EmojiInteractorDelegateMock.swift
//  GitEmojiTests
//
//  Created by Wellington on 05/12/22.
//

@testable import GitEmoji

final class EmojiInteractorDelegateMock: EmojiInteractorDelegate {
    
    var methods: [Method] = []
    var emojis: [String: String]?
    
    func didFetchEmojiList(emojiList: [String : String], isCached: Bool) {
        self.emojis = emojiList
        self.methods.append(.didFetchEmojiList)
    }
    
    func didNotFetchEmojiList() {
        self.methods.append(.didNotFetchEmojiList)
    }
    
    func didGetRandomEmojiImage(url: String?) {
        self.methods.append(.didGetRandomEmojiImage)
    }
    
    enum Method {
        case didFetchEmojiList
        case didNotFetchEmojiList
        case didGetRandomEmojiImage
    }
}
