//
//  EmojiListRouter.swift
//  GitEmoji
//
//  Created by Wellington on 04/12/22.
//

final class GenericListRouter {
    
    private weak var viewController: GenericListViewController?
    
    func getViewController(listType: GenericListPresenter.ListType) -> GenericListViewController {
        
        let presenter = GenericListPresenter()
        presenter.setUp(listType: listType)
        presenter.set(router: self)
        
        let genericListViewController = GenericListViewController()
        genericListViewController.setUp(presenter: presenter)
        
        presenter.setUp(delegate: genericListViewController)
        
        self.viewController = genericListViewController
        
        return genericListViewController
    }
}
