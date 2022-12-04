//
//  HomeViewController.swift
//  GitEmoji
//
//  Created by Wellington Bezerra on 11/30/22.
//

import UIKit

final class HomeViewController: UIViewController {

    private var presenter: HomePresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setUp(presenter: HomePresenterProtocol) {
        self.presenter = presenter
    }
    
    @IBAction private func didSelectRandomEmojiButton(_ sender: Any) {
        
    }
    
    @IBAction private func didSelectEmojiListButton(_ sender: Any) {
        
    }
    
    @IBAction private func didSelectAvatarListButton(_ sender: Any) {
    }
    
    @IBAction private func didSelectAppleReposButton(_ sender: Any) {
        self.presenter?.didSelectAppleReposButton()
    }
    
    @IBAction private func didSelectSearchButton(_ sender: Any) {
    }
    
    
    @IBAction private func didSelectFetchEmojiButton(_ sender: Any) {
        self.presenter?.didSelectFetchEmojiButton()
    }
    
    
}

