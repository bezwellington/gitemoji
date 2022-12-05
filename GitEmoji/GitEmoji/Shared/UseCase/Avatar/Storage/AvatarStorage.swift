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
}

final class AvatarStorage: AvatarStorageProtocol {
    
    private let userDefaults: ObjectSavable
    private let key: String = "avatarList"
    
    init(userDefaults: ObjectSavable = UserDefaults(suiteName: "gitEmoji.avatarList") ?? .standard) {
        self.userDefaults = userDefaults
    }
    
    func save(avatar: Avatar) {
        let dict = [avatar.login.lowercased(): avatar.avatar_url]
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
}
