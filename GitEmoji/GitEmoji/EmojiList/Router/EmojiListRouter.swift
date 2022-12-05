//
//  EmojiListRouter.swift
//  GitEmoji
//
//  Created by Wellington on 04/12/22.
//

final class EmojiListRouter {
    
    private weak var viewController: EmojiListViewController?
    
    func getViewController(listType: EmojiListPresenter.ListType) -> EmojiListViewController {
        
        let presenter = EmojiListPresenter()
        presenter.setUp(listType: listType)
        presenter.set(router: self)
        
        let emojiListViewController = EmojiListViewController()
        emojiListViewController.setUp(presenter: presenter)
        
        presenter.setUp(delegate: emojiListViewController)
        
        self.viewController = emojiListViewController
        
        return emojiListViewController
    }
}
