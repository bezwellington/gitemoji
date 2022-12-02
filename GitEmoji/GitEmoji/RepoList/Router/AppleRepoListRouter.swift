//
//  AppleRepoRouter.swift
//  GitEmoji
//
//  Created by Wellington Bezerra on 12/1/22.
//


final class AppleRepoListRouter {
    
    private weak var viewController: AppleRepoListViewController?
    
    func getViewController() -> AppleRepoListViewController {
        
        let presenter = AppleRepoListPresenter()
        presenter.set(router: self)
        
        let appleRepoListViewController = AppleRepoListViewController()
        appleRepoListViewController.setUp(presenter: presenter)
        
        presenter.setUp(delegate: appleRepoListViewController)
        
        self.viewController = appleRepoListViewController
        
        return appleRepoListViewController
    }
}
