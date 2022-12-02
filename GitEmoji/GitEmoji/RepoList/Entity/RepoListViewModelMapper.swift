//
//  RepoListViewModelMapper.swift
//  GitEmoji
//
//  Created by Wellington Bezerra on 12/1/22.
//

final class RepoViewModelMapper {
    
    static func make(repoList: [Repo]) -> [RepoViewModel] {
        return repoList.map({ self.make(repoName: $0.name) })
    }
    
    static func make(repoName: String) -> RepoViewModel {
        return RepoViewModel(name: repoName)
    }
}
