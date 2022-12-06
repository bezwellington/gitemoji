//
//  AvatarAdaptermOCK.swift
//  GitEmojiTests
//
//  Created by Wellington on 05/12/22.
//

@testable import GitEmoji

final class AvatarAdapterMock: AvatarAdapterProtocol {
    
    var methods: [Method] = []
    var delegate: AvatarAdapterDelegate?
    var avatar: Avatar?
    var isSuccess: Bool = true
    
    func fetchAvatar(text: String) {
        self.methods.append(.fetchAvatar)

        if let avatar = self.avatar, self.isSuccess {
            self.delegate?.didFetchAvatar(avatar: avatar)
        } else {
            self.delegate?.didNotFetchAvatar()
        }
    }
    
    func setUp(delegate: GitEmoji.AvatarAdapterDelegate) {
        self.delegate = delegate
        self.methods.append(.setUpDelegate)
    }
    
    enum Method {
        case fetchAvatar
        case setUpDelegate
    }
}
