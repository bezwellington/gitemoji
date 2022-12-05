//
//  HomeInteractor.swift
//  GitEmoji
//
//  Created by Wellington on 03/12/22.
//

protocol HomeInteractorProtocol {
    func setUp(delegate: HomeInteractorDelegate)
    func fetchEmojiList()
    func getRandomEmoji()
    func fetchAvatar(text: String)
}

protocol HomeInteractorDelegate: AnyObject {
    func didGetRandomEmojiImage(url: String?)
    
    func didFetchEmojiList(isCached: Bool)
    
    func didFetchAvatar(avatar: Avatar)
    func didNotFetchAvatar()
}


final class HomeInteractor {
    
    weak private var delegate: HomeInteractorDelegate?
    
    private let emojiInteractor: EmojiInteractorProtocol
    private let avatarInteractor: AvatarInteractorProtocol
    
    init(emojiInteractor: EmojiInteractorProtocol = EmojiInteractor(),
         avatarInteractor: AvatarInteractorProtocol = AvatarInteractor()) {
        
        self.emojiInteractor = emojiInteractor
        self.avatarInteractor = avatarInteractor

        self.emojiInteractor.setUp(delegate: self)
        self.avatarInteractor.setUp(delegate: self)
    }
}

extension HomeInteractor: HomeInteractorProtocol {
    
    func setUp(delegate: HomeInteractorDelegate) {
        self.delegate = delegate
    }
    
    func fetchEmojiList() {
        self.emojiInteractor.fetchEmojiList()
    }
    
    func getRandomEmoji() {
        self.emojiInteractor.getRandomEmojiImageURL()
    }
    
    func fetchAvatar(text: String) {
        self.avatarInteractor.fetchAvatar(text: text)
    }
}

extension HomeInteractor: EmojiInteractorDelegate {
 
    func didFetchEmojiList(emojiList: [String : String], isCached: Bool) {
        self.delegate?.didFetchEmojiList(isCached: isCached)
    }
    
    func didNotFetchEmojiList() {}
    
    func didGetRandomEmojiImage(url: String?) {
        self.delegate?.didGetRandomEmojiImage(url: url)
    }
}


extension HomeInteractor: AvatarInteractorDelegate {
    
    func didFetchAvatar(avatar: Avatar, isCached: Bool) {
        self.delegate?.didFetchAvatar(avatar: avatar)
    }
    
    func didNotFetchAvatar() {
        self.delegate?.didNotFetchAvatar()
    }
}
