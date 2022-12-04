//
//  EmojiStorage.swift
//  GitEmoji
//
//  Created by Wellington on 03/12/22.
//

import Foundation

protocol EmojiStorageProtocol {
    func save(emojiList: [String: String])
    func getEmojiList() -> [String: String]?
}

final class EmojiStorage: EmojiStorageProtocol {
    
    private let userDefaults: ObjectSavable
    private let key: String = "emojiList"
    
    init(userDefaults: ObjectSavable = UserDefaults(suiteName: "gitEmoji.emojiList") ?? .standard) {
        self.userDefaults = userDefaults
    }
    
    func save(emojiList: [String: String]) {
        try? self.userDefaults.setObject(emojiList, forKey: self.key)
    }
    
    func getEmojiList() -> [String: String]? {
        return try? self.userDefaults.getObject([String: String].self, forKey: self.key)
    }
}

