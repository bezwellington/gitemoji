//
//  HomeInteractor.swift
//  GitEmoji
//
//  Created by Wellington on 03/12/22.
//

protocol HomeInteractorProtocol {
    func fetchEmojiList()
}

protocol HomeInteractorDelegate: AnyObject {
    func didFetchEmojiList(emojiList: [String : String])
    func didNotFetchEmojiList()
}


final class HomeInteractor {
    
    weak private var delegate: HomeInteractorDelegate?
    
    private let emojiInteractor: EmojiInteractorProtocol
    
    init(emojiInteractor: EmojiInteractorProtocol = EmojiInteractor()) {
        self.emojiInteractor = emojiInteractor
    }
}

extension HomeInteractor: HomeInteractorProtocol {
    
    func setUp(delegate: HomeInteractorDelegate) {
        self.delegate = delegate
    }
    
    func fetchEmojiList() {
        self.emojiInteractor.fetchEmojiList()
    }
}
