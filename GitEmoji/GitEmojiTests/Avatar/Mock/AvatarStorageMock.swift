//
//  AvatarStorageMock.swift
//  GitEmojiTests
//
//  Created by Wellington on 05/12/22.
//

@testable import GitEmoji

final class AvatarStorageMock: AvatarStorageProtocol {
    
    var method: Method = .none
    private var avatars: [String: String]?
    
    func save(avatar: GitEmoji.Avatar) {
        self.method = .saveAvatar
        
        if self.avatars == nil {
            self.avatars = [:]
        }
        
        let key = avatar.login
        let value = avatar.avatar_url
        self.avatars?[key] = value
    }
    
    func getAvatar(login: String) -> GitEmoji.Avatar? {
        self.method = .getAvatar
        
        if let avatarImageURL = avatars?[login] {
            return AvatarMapper.make(login: login, imageURL: avatarImageURL)
        } else {
            return nil
        }
    }
    
    func getAvatarList() -> [String : String]? {
        self.method = .getAvatarList
      
        return self.avatars
    }
    
    func removeAvatar(avatarID: String) {
        self.method = .removeAvatar
        
        self.avatars?.removeValue(forKey: avatarID)
    }
    
    enum Method {
        case none
        case saveAvatar
        case getAvatar
        case getAvatarList
        case removeAvatar
    }
}
