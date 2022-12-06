//
//  EmojiListViewController.swift
//  GitEmoji
//
//  Created by Wellington on 04/12/22.
//

import UIKit


// MARK: - Class

final class GenericListViewController: UIViewController {

    @IBOutlet weak private var collectionView: UICollectionView!
    
    private var presenter: GenericListPresenterProtocol?

    private var genericList: [GenericViewModel] = []
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupCollectionView()
        self.setUpRefreshControl()
        
        self.presenter?.viewDidLoad()
    }
    
    func setUp(presenter: GenericListPresenterProtocol) {
        self.presenter = presenter
    }
    
    private func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView?.registerNib(EmojiCollectionViewCell.self)
    }
    
    private func setUpRefreshControl() {
        self.refreshControl.tintColor = .white
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: #selector(self.didRefresh(_:)), for: .allEvents)
        self.collectionView.addSubview(self.refreshControl)
    }
    
    @objc private func didRefresh(_ sender: AnyObject) {
        self.presenter?.didRefresh()
    }
}


// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension GenericListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.genericList.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.collectionView?.dequeueReusableCell(withReuseIdentifier: "EmojiCollectionViewCell", for: indexPath) as? EmojiCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let emoji = self.genericList[indexPath.row]
        cell.setUp(imageURL: emoji.imageURL)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let emojiViewModel = self.genericList[indexPath.row]

        let showAlert = UIAlertController(title: "Atenção", message: "Deseja remover esse emoji ?", preferredStyle: .alert)
        let imageView = UIImageView(frame: CGRect(x: 100, y: 70, width: 50, height: 50))
        imageView.sd_setImage(with: URL(string: emojiViewModel.imageURL))
        showAlert.view.addSubview(imageView)
        
        let height = NSLayoutConstraint(item: showAlert.view as Any, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200)
        let width = NSLayoutConstraint(item: showAlert.view as Any, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200)
        showAlert.view.addConstraint(height)
        showAlert.view.addConstraint(width)
        
        showAlert.addAction(UIAlertAction(title: "Não", style: .cancel, handler: nil))
        let comfirmButton = UIAlertAction(title: "Sim", style: .default) { _ in
            self.presenter?.didSelect(genericViewModel: emojiViewModel)
        }
        showAlert.addAction(comfirmButton)
        
        self.present(showAlert, animated: true, completion: nil)
    }
    
}


// MARK: - UICollectionViewDelegateFlowLayout

extension GenericListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let collectionWidth = self.collectionView?.frame.width else { return CGSize(width: 0, height: 0)}
        let size = (collectionWidth - 5*24)/4
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    }
}


// MARK: - GenericListPresenterDelegate

extension GenericListViewController: GenericListPresenterDelegate {

    func show(genericList: [GenericViewModel]) {
        DispatchQueue.main.async {
            self.genericList = genericList
            self.collectionView.reloadData()
        }
    }
    
    func showTitle(text: String) {
        self.title = text
    }
    
    func stopLoading() {
        //
    }
    
    func endRefreshing() {
        self.refreshControl.endRefreshing()
    }
}
