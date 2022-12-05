//
//  AvatarStorage.swift
//  GitEmoji
//
//  Created by Wellington on 04/12/22.
//

import Foundation

protocol AvatarStorageProtocol {
    func save(avatar: Avatar)
    func getAvatar(login: String) -> Avatar?
    func getAvatarList() -> [String: String]?
    func removeAvatar(avatarID: String)
}

final class AvatarStorage: AvatarStorageProtocol {
    
    private let userDefaults: ObjectSavable
    private let key: String = "avatarList"
    
    init(userDefaults: ObjectSavable = UserDefaults(suiteName: "gitEmoji.avatarList") ?? .standard) {
        self.userDefaults = userDefaults
    }
    
    func save(avatar: Avatar) {
        var dict = self.getAvatarList()
        dict?[avatar.login.lowercased()] = avatar.avatar_url
        try? self.userDefaults.setObject(dict, forKey: self.key)
    }
    
    func getAvatar(login: String) -> Avatar? {
        let avatarList = try? self.userDefaults.getObject([String: String].self, forKey: self.key)
        if let avatarImageURL = avatarList?[login.lowercased()] {
            return AvatarMapper.make(login: login, imageURL: avatarImageURL)
        } else {
            return nil
        }
    }
    
    func getAvatarList() -> [String: String]? {
        return try? self.userDefaults.getObject([String: String].self, forKey: self.key)
    }
    
    func removeAvatar(avatarID: String) {
        var dict = self.getAvatarList()
        dict?.removeValue(forKey: avatarID)
        try? self.userDefaults.setObject(dict, forKey: self.key)
    }
}
