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
        let genericListViewController = GenericListRouter().getViewController(listType: .emoji)
        self.viewController?.navigationController?.pushViewController(genericListViewController, animated: true)
    }
    

    func openAvatarListViewController() {
        let genericListViewController = GenericListRouter().getViewController(listType: .avatar)
        self.viewController?.navigationController?.pushViewController(genericListViewController, animated: true)
    }

    func openAppleReposViewController() {
        let appleRepoListViewController = AppleRepoListRouter().getViewController()
        self.viewController?.navigationController?.pushViewController(appleRepoListViewController, animated: true)
    }

    func openSearchViewController() {}
}


