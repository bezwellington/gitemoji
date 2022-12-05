//
//  AvatarMapper.swift
//  GitEmoji
//
//  Created by Wellington on 04/12/22.
//

final class AvatarMapper {
    
    static func make(login: String, imageURL: String) -> Avatar {
        return Avatar(login: login, avatar_url: imageURL)
    }
}
