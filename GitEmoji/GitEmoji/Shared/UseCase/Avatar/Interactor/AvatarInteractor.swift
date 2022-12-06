//
//  AvatarInteractor.swift
//  GitEmoji
//
//  Created by Wellington on 04/12/22.
//


// MARK: - Protocol

protocol AvatarInteractorProtocol {
    func setUp(delegate: AvatarInteractorDelegate)
    func fetchAvatar(text: String)
    func fetchAvatarListFromCache() -> [String: String]?
    func removeAvatar(avatarID: String)
}


// MARK: - Delegate

protocol AvatarInteractorDelegate: AnyObject {
    func didFetchAvatar(avatar: Avatar, isCached: Bool)
    func didNotFetchAvatar()
}


// MARK: - Class

final class AvatarInteractor {
    
    private weak var delegate: AvatarInteractorDelegate?
    
    private let adapter: AvatarAdapterProtocol
    private let storage: AvatarStorageProtocol
    
    init(adapter: AvatarAdapterProtocol = AvatarAdapter(),
         storage: AvatarStorageProtocol = AvatarStorage()) {
        
        self.adapter = adapter
        self.storage = storage
        
        self.adapter.setUp(delegate: self)
    }
    
    func setUp(delegate: AvatarInteractorDelegate) {
        self.delegate = delegate
    }
}


// MARK: - AvatarInteractorProtocol

extension AvatarInteractor: AvatarInteractorProtocol {
    
    func fetchAvatar(text: String) {

        if let avatar = self.storage.getAvatar(login: text) {
            self.delegate?.didFetchAvatar(avatar: avatar, isCached: true)
        } else {
            self.adapter.fetchAvatar(text: text)
        }
    }
    
    func fetchAvatarListFromCache() -> [String: String]? {
        let avatarList = self.storage.getAvatarList()
        return avatarList
    }
    
    func removeAvatar(avatarID: String) {
        self.storage.removeAvatar(avatarID: avatarID)
    }
}


// MARK: - AvatarAdapterDelegate

extension AvatarInteractor: AvatarAdapterDelegate {
    
    func didFetchAvatar(avatar: Avatar) {
        if self.storage.getAvatar(login: avatar.login) == nil {
            self.storage.save(avatar: avatar)
        }
        
        self.delegate?.didFetchAvatar(avatar: avatar, isCached: false)
    }
    
    func didNotFetchAvatar() {
        self.delegate?.didNotFetchAvatar()
    }
}
