//
//  GenericListPresenter.swift
//  GitEmoji
//
//  Created by Wellington on 04/12/22.
//

// MARK: - Protocol

protocol GenericListPresenterProtocol {
    func setUp(delegate: GenericListPresenterDelegate)
    func setUp(listType: GenericListPresenter.ListType)
    func set(router: GenericListRouter)
    func viewDidLoad()
    func didSelect(genericViewModel: GenericViewModel)
    func didRefresh()
}


// MARK: - Delegate

protocol GenericListPresenterDelegate: AnyObject {
    func show(genericList: [GenericViewModel])
    func showTitle(text: String)
    func stopLoading()
    func endRefreshing()
}


// MARK: - Class

final class GenericListPresenter {
    
    private weak var delegate: GenericListPresenterDelegate?

    private let interactor: GenericListInteractorProtocol
    private var router: GenericListRouter?
    
    private var genericList: [GenericViewModel] = []
    private var filteredGenericList: [GenericViewModel] = []
    private var listType: ListType = .none

    init(interactor: GenericListInteractorProtocol = GenericListInteractor()) {
        self.interactor = interactor
        self.interactor.setUp(delegate: self)
    }
}


// MARK: - GenericListPresenterProtocol

extension GenericListPresenter: GenericListPresenterProtocol {

    func set(router: GenericListRouter) {
        self.router = router
    }
    
    func setUp(delegate: GenericListPresenterDelegate) {
        self.delegate = delegate
    }
    
    func setUp(listType: GenericListPresenter.ListType) {
        self.listType = listType
    }

    func viewDidLoad() {
        if self.listType == .emoji {
            self.interactor.fetchEmojiList()
            self.delegate?.showTitle(text: "Emoji List")
        } else {
            self.interactor.fetchAvatarList()
            self.delegate?.showTitle(text: "Avatar List")
        }
    }
    
    func didSelect(genericViewModel: GenericViewModel) {
        if self.listType == .emoji {
            self.removeFromFilteredGenericList(genericViewModel: genericViewModel)
        } else {
            self.removeFromGenericList(genericViewModel: genericViewModel)
        }
    }
    
    private func removeFromFilteredGenericList(genericViewModel: GenericViewModel) {
        if let index = self.filteredGenericList.firstIndex(where: {$0.id == genericViewModel.id}) {
            self.filteredGenericList.remove(at: index)
        }
        self.delegate?.show(genericList: self.filteredGenericList)
    }
    
    private func removeFromGenericList(genericViewModel: GenericViewModel) {
        if let index = self.genericList.firstIndex(where: {$0.id == genericViewModel.id}) {
            self.genericList.remove(at: index)
        }
        self.delegate?.show(genericList: self.genericList)
        
        self.interactor.removeAvatar(avatarID: genericViewModel.id)
    }
    
    func didRefresh() {
        self.delegate?.show(genericList: self.genericList)
        
        self.delegate?.endRefreshing()
    }
}


// MARK: - GenericListInteractorDelegate

extension GenericListPresenter: GenericListInteractorDelegate {
    
    func didFetchList(list: [String : String]) {
        let GenericListViewModel = GenericViewModelMapper.make(genericList: list)
        
        self.genericList = GenericListViewModel
        self.filteredGenericList = GenericListViewModel
        
        self.delegate?.show(genericList: GenericListViewModel)
    }
    
    func didNotFetchList() {
        self.delegate?.stopLoading()
    }
}


// MARK: - Enum - ListType

extension GenericListPresenter {
    
    enum ListType {
        case emoji
        case avatar
        case none
    }
}
