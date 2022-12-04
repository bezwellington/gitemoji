//
//  EmojiViewModelMapper.swift
//  GitEmoji
//
//  Created by Wellington on 04/12/22.
//

final class EmojiViewModelMapper {
    
    static func make(emojiList: [String: String]) -> [EmojiViewModel] {
        return emojiList.map({ self.make(id: $0.key, imageURL: $0.value) })
    }
    
    static func make(id: String, imageURL: String) -> EmojiViewModel {
        return EmojiViewModel(id: id, imageURL: imageURL)
    }
}
