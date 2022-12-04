//
//  RepoStorage.swift
//  GitEmoji
//
//  Created by Wellington Bezerra on 12/1/22.
//

import Foundation

protocol RepoStorageProtocol {
    func save(repoList: [Repo])
    func getRepoList() -> [Repo]?
}

final class RepoStorage: RepoStorageProtocol {
    
    private let userDefaults: ObjectSavable
    private let key: String = "repoList"
    
    init(userDefaults: ObjectSavable = UserDefaults(suiteName: "gitEmoji.repoList") ?? .standard) {
        self.userDefaults = userDefaults
    }
    
    func save(repoList: [Repo]) {
        var repoStorage = try? self.userDefaults.getObject([Int: Repo].self, forKey: self.key)
        if repoStorage == nil {
            repoStorage = [Int: Repo]()
        }
        repoList.forEach { repo in
            if repoStorage?[repo.id] == nil {
                repoStorage?[repo.id] = repo
            }
        }
        
        try? self.userDefaults.setObject(repoStorage, forKey: self.key)
    }
    
    func getRepoList() -> [Repo]? {
        let repoList = try? self.userDefaults.getObject([Int: Repo].self, forKey: self.key)
        let repo = repoList?.compactMap({ $1 })
        return repo
    }
}
