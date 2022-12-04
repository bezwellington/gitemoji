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
}

protocol HomeInteractorDelegate: AnyObject {
    func didGetRandomEmojiImage(url: String)
}


final class HomeInteractor {
    
    weak private var delegate: HomeInteractorDelegate?
    
    private let emojiInteractor: EmojiInteractorProtocol
    
    init(emojiInteractor: EmojiInteractorProtocol = EmojiInteractor()) {
        self.emojiInteractor = emojiInteractor
        self.emojiInteractor.setUp(delegate: self)
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
}

extension HomeInteractor: EmojiInteractorDelegate {
    
    func didFetchEmojiList(emojiList: [String : String]) {}
    func didNotFetchEmojiList() {}
    
    func didGetRandomEmojiImage(url: String) {
        self.delegate?.didGetRandomEmojiImage(url: url)
    }
}
