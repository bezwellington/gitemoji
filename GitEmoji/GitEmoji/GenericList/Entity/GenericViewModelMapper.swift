//
//  GenericViewModelMapper.swift
//  GitEmoji
//
//  Created by Wellington on 04/12/22.
//

final class GenericViewModelMapper {
    
    static func make(genericList: [String: String]) -> [GenericViewModel] {
        return genericList.map({ self.make(id: $0.key, imageURL: $0.value) })
    }
    
    static func make(id: String, imageURL: String) -> GenericViewModel {
        return GenericViewModel(id: id, imageURL: imageURL)
    }
}
