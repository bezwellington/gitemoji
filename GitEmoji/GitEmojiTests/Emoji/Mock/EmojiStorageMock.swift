//
//  EmojiStorage.swift
//  GitEmojiTests
//
//  Created by Wellington on 05/12/22.
//

@testable import GitEmoji

final class EmojiStorageMock: EmojiStorageProtocol {
    
    var method: Method = .none
    private var emojis: [String: String]?

    func save(emojiList: [String : String]) {
        self.method = .saveEmoji
        self.emojis = emojiList
    }
    
    func getEmojiList() -> [String : String]? {
        self.method = .getEmojiList
        return self.emojis
    }
    
    enum Method {
        case none
        case saveEmoji
        case getEmojiList
    }
}
