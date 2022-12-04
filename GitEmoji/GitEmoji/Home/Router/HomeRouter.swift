//
//  HomeRouter.swift
//  GitEmoji
//
//  Created by Wellington Bezerra on 11/30/22.
//

final class HomeRouter {
    
    private weak var viewController: HomeViewController?
    
    func getViewController() -> HomeViewController {
        
        let presenter = HomePresenter()
        presenter.set(router: self)
        
        let homeViewController = HomeViewController()
        homeViewController.setUp(presenter: presenter)
                
        presenter.setUp(delegate: homeViewController)
        
        self.viewController = homeViewController
        
        return homeViewController
    }
    
    func openEmojiListViewController() {
        let emojiListViewController = EmojiListRouter().getViewController()
        self.viewController?.navigationController?.pushViewController(emojiListViewController, animated: true)
    }
    

    func openAvatarListViewController() {}

    func openAppleReposViewController() {
        let appleRepoListViewController = AppleRepoListRouter().getViewController()
        self.viewController?.navigationController?.pushViewController(appleRepoListViewController, animated: true)
    }

    func openSearchViewController() {}
}


