//
//  EmojiAdapter.swift
//  GitEmoji
//
//  Created by Wellington on 03/12/22.
//

import Foundation

protocol EmojiAdapterProtocol {
    func fetchEmojiList()
    func setUp(delegate: EmojiAdapterDelegate)
}

protocol EmojiAdapterDelegate: AnyObject {
    func didFetchEmojiList(emojiList: [String: String])
    func didNotFetchEmojiList()
}

final class EmojiAdapter {
    
    private weak var delegate: EmojiAdapterDelegate?
    
    private let baseURL: String = "https://api.github.com/emojis"
}

extension EmojiAdapter: EmojiAdapterProtocol {
    
    func setUp(delegate: EmojiAdapterDelegate) {
        self.delegate = delegate
    }
    
    func fetchEmojiList() {
                
        guard let url = URL(string: baseURL) else { return }

        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            
            guard error == nil else {
                self?.delegate?.didNotFetchEmojiList()
                return
            }
            
            guard let data = data, let emojiList = try? JSONDecoder().decode([String: String].self, from: data) else {
                self?.delegate?.didNotFetchEmojiList()
                return
            }
            self?.delegate?.didFetchEmojiList(emojiList: emojiList)
        }
        
        task.resume()
    }
}
