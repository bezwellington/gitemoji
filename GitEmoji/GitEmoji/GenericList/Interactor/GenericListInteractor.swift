//
//  GenericListInteractor.swift
//  GitEmoji
//
//  Created by Wellington on 04/12/22.
//

// MARK: - Protocol

protocol GenericListInteractorProtocol {
    func setUp(delegate: GenericListInteractorDelegate)
    func fetchEmojiList()
    func fetchAvatarList()
    func removeAvatar(avatarID: String)
}


// MARK: - Delegate

protocol GenericListInteractorDelegate: AnyObject {
    func didFetchList(list: [String: String])
    func didNotFetchList()
}

// MARK: - Class

final class GenericListInteractor {
    
    private weak var delegate: GenericListInteractorDelegate?
    
    private let emojiInteractor: EmojiInteractorProtocol
    private let avatarInteractor: AvatarInteractorProtocol
    
    init(emojiInteractor: EmojiInteractorProtocol = EmojiInteractor(),
         avatarInteractor: AvatarInteractorProtocol = AvatarInteractor()) {
        
        self.emojiInteractor = emojiInteractor
        self.avatarInteractor = avatarInteractor
    }
}


// MARK: - GenericListAdapterProtocol

extension GenericListInteractor: GenericListInteractorProtocol {
    
    func setUp(delegate: GenericListInteractorDelegate) {
        self.delegate = delegate
    }
    
    func fetchAvatarList() {
        let avatarList = self.avatarInteractor.fetchAvatarListFromCache() ?? [:]
        self.delegate?.didFetchList(list: avatarList)
    }
    
    func fetchEmojiList() {
        let emojiListList = self.emojiInteractor.fetchEmojiListFromCache() ?? [:]
        self.delegate?.didFetchList(list: emojiListList)
    }
    
    func removeAvatar(avatarID: String) {
        self.avatarInteractor.removeAvatar(avatarID: avatarID)
    }
}
