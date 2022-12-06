//
//  AvatarAdapter.swift
//  GitEmoji
//
//  Created by Wellington on 04/12/22.
//


import Foundation


// MARK: - Protocol

protocol AvatarAdapterProtocol {
    func fetchAvatar(text: String)
    func setUp(delegate: AvatarAdapterDelegate)
}


// MARK: - Delegate

protocol AvatarAdapterDelegate: AnyObject {
    func didFetchAvatar(avatar: Avatar)
    func didNotFetchAvatar()
}


// MARK: - Class

final class AvatarAdapter {
    
    private weak var delegate: AvatarAdapterDelegate?
    
    private let baseURL: String = "https://api.github.com/users/"
}


// MARK: - AvatarAdapterProtocol

extension AvatarAdapter: AvatarAdapterProtocol {
    
    func setUp(delegate: AvatarAdapterDelegate) {
        self.delegate = delegate
    }
    
    func fetchAvatar(text: String) {
                
        guard let url = URL(string: self.baseURL + text) else {
            self.delegate?.didNotFetchAvatar()
            return
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            
            guard error == nil else {
                self?.delegate?.didNotFetchAvatar()
                return
            }
            
            guard let data = data, let avatar = try? JSONDecoder().decode(Avatar.self, from: data) else {
                self?.delegate?.didNotFetchAvatar()
                return
            }
            
            self?.delegate?.didFetchAvatar(avatar: avatar)
        }
        
        task.resume()
    }
}
