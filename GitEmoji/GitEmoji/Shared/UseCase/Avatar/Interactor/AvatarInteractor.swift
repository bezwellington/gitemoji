//
//  AvatarInteractor.swift
//  GitEmoji
//
//  Created by Wellington on 04/12/22.
//

protocol AvatarInteractorProtocol {
    func setUp(delegate: AvatarInteractorDelegate)
    func fetchAvatar(text: String)
}

protocol AvatarInteractorDelegate: AnyObject {
    func didFetchAvatar(avatar: Avatar, isCached: Bool)
    func didNotFetchAvatar()
}

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

extension AvatarInteractor: AvatarInteractorProtocol {
    
    func fetchAvatar(text: String) {

        if let avatar = self.storage.getAvatar(login: text) {
            self.delegate?.didFetchAvatar(avatar: avatar, isCached: true)
        } else {
            self.adapter.fetchAvatar(text: text)
        }
    }
}

extension AvatarInteractor: AvatarAdapterDelegate {
    
    func didFetchAvatar(avatar: Avatar) {
        self.storage.save(avatar: avatar)
        
        self.delegate?.didFetchAvatar(avatar: avatar, isCached: false)
    }
    
    func didNotFetchAvatar() {
        self.delegate?.didNotFetchAvatar()
    }
}
