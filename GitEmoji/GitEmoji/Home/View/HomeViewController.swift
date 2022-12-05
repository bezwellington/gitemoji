//
//  HomeViewController.swift
//  GitEmoji
//
//  Created by Wellington Bezerra on 11/30/22.
//

import UIKit

final class HomeViewController: UIViewController {

    @IBOutlet weak private var emojiImageView: UIImageView!
    @IBOutlet weak private var searchBar: UISearchBar!
    
    
    private var presenter: HomePresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.emojiImageView.image = UIImage(systemName: "questionmark.app.fill")
    }
  
    func setUp(presenter: HomePresenterProtocol) {
        self.presenter = presenter
    }
    
    @IBAction private func didSelectRandomEmojiButton(_ sender: Any) {
        self.presenter?.didSelectRandomEmojiButton()
    }
    
    @IBAction private func didSelectEmojiListButton(_ sender: Any) {
        self.presenter?.didSelectEmojiListButton()
    }
    
    @IBAction private func didSelectAvatarListButton(_ sender: Any) {
        self.presenter?.didSelectAvatarListButton()
    }
    
    @IBAction private func didSelectAppleReposButton(_ sender: Any) {
        self.presenter?.didSelectAppleReposButton()
    }
    
    @IBAction private func didSelectSearchButton(_ sender: Any) {
        self.presenter?.didSelectSearchButton(text: self.searchBar.text)
    }
    
    
    @IBAction private func didSelectFetchEmojiButton(_ sender: Any) {
        self.presenter?.didSelectFetchEmojiButton()
    }
    
    
}

extension HomeViewController: HomePresenterDelegate {
    
    func showAlert(title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showRandomEmoji(imageURL: String) {
        guard let url = URL(string: imageURL) else { return }
        self.emojiImageView.sd_setImage(with: url)
    }
}
