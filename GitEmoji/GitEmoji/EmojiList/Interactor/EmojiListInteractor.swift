//
//  EmojiListInteractor.swift
//  GitEmoji
//
//  Created by Wellington on 04/12/22.
//

// MARK: - Protocol

protocol EmojiListInteractorProtocol {
    func setUp(delegate: EmojiListInteractorDelegate)
    func fetchEmojiList()
    func fetchAvatarList()
    func removeAvatar(avatarID: String)
}


// MARK: - Delegate

protocol EmojiListInteractorDelegate: AnyObject {
    func didFetchList(list: [String: String])
    func didNotFetchList()
}

// MARK: - Class

final class EmojiListInteractor {
    
    private weak var delegate: EmojiListInteractorDelegate?
    
    private let emojiStorage: EmojiStorageProtocol
    private let avatarStorage: AvatarStorageProtocol
    
    init(emojiStorage: EmojiStorageProtocol = EmojiStorage(),
         avatarStorage: AvatarStorageProtocol = AvatarStorage()) {
        
        self.emojiStorage = emojiStorage
        self.avatarStorage = avatarStorage
    }
}


// MARK: - EmojiListAdapterProtocol

extension EmojiListInteractor: EmojiListInteractorProtocol {
    
    func fetchAvatarList() {
        let avatarList = self.avatarStorage.getAvatarList() ?? [:]
        self.delegate?.didFetchList(list: avatarList)
    }
    
    func setUp(delegate: EmojiListInteractorDelegate) {
        self.delegate = delegate
    }
    
    func fetchEmojiList() {
        let emojiList = self.emojiStorage.getEmojiList() ?? [:]
        self.delegate?.didFetchList(list: emojiList)
    }
    
    func removeAvatar(avatarID: String) {
        self.avatarStorage.removeAvatar(avatarID: avatarID)
    }
}
