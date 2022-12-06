//
//  AvatarInteractorDelegateMock.swift
//  GitEmojiTests
//
//  Created by Wellington on 05/12/22.
//

@testable import GitEmoji

final class AvatarInteractorDelegateMock: AvatarInteractorDelegate {
    
    var methods: [Method] = []
    var avatar: Avatar?
    
    func didFetchAvatar(avatar: GitEmoji.Avatar, isCached: Bool) {
        self.avatar = avatar
        self.methods.append(.didFetchAvatar)
    }
    
    func didNotFetchAvatar() {
        self.methods.append(.didNotFetchAvatar)
    }
    
    enum Method {
        case didFetchAvatar
        case didNotFetchAvatar
    }
}
