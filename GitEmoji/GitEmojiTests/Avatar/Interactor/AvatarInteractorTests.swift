//
//  GitEmojiTests.swift
//  GitEmojiTests
//
//  Created by Wellington on 05/12/22.
//

import XCTest
@testable import GitEmoji

final class AvatarInteractorTests: XCTestCase {

    private var sut: AvatarInteractor!
    private var storage: AvatarStorageMock!
    private var adapter: AvatarAdapterMock!
    private var delegate: AvatarInteractorDelegateMock!
    
    override func setUp() {
        super.setUp()
    }

    private func setUpSut() {
        self.storage = AvatarStorageMock()
        self.adapter = AvatarAdapterMock()
        self.delegate = AvatarInteractorDelegateMock()
        
        self.sut = AvatarInteractor(adapter: self.adapter, storage: self.storage)
        
        self.sut.setUp(delegate: self.delegate)
    }
    
    func test_fetchAvatar_FromCache() {
        // GIVEN
        self.setUpSut()

        let avatarID = "avatarID"
        let avatar = Avatar(login: avatarID, avatar_url: "url")
        self.storage.save(avatar: avatar)

        // WHEN
        self.sut.fetchAvatar(text: avatarID)

        // THEN
        let avatarList = self.storage.getAvatarList()
        XCTAssertEqual(avatarList?.count, 1)
        XCTAssertEqual(self.delegate.methods, [.didFetchAvatar])
        XCTAssertEqual(self.delegate.avatar, avatar)
        XCTAssertEqual(self.adapter.methods, [.setUpDelegate])
    }
    
    func test_fetchAvatar_FromServer_WithSuccess() {
        // GIVEN
        self.setUpSut()
        
        let avatar = Avatar(login: "ID", avatar_url: "url")
        self.adapter.avatar = avatar
        self.adapter.isSuccess = true
        
        // WHEN
        self.sut.fetchAvatar(text: "test")
        
        // THEN
        XCTAssertEqual(self.delegate.methods, [.didFetchAvatar])
        XCTAssertEqual(self.delegate.avatar, avatar)
        XCTAssertEqual(self.adapter.methods, [.setUpDelegate, .fetchAvatar])
    }
    
    func test_fetchAvatar_FromServer_WithError() {
        // GIVEN
        self.setUpSut()
        
        self.adapter.isSuccess = false
        
        // WHEN
        self.sut.fetchAvatar(text: "test")
        
        // THEN
        XCTAssertEqual(self.delegate.methods, [.didNotFetchAvatar])
        XCTAssertEqual(self.delegate.avatar, nil)
        XCTAssertEqual(self.adapter.methods, [.setUpDelegate, .fetchAvatar])
    }
    
    func test_fetchAvatarListFromCache_WithCache() {
        // GIVEN
        self.setUpSut()
        
        let avatar1 = Avatar(login: "login1", avatar_url: "url1")
        self.storage.save(avatar: avatar1)
        
        let avatar2 = Avatar(login: "login2", avatar_url: "url2")
        self.storage.save(avatar: avatar2)
        
        let avatarList = [avatar1, avatar2]
        
        // WHEN
        let avatarListFromCache = self.sut.fetchAvatarListFromCache()
        
        // THEN
        XCTAssertEqual(avatarList.count, avatarListFromCache?.count)
    }

    func test_fetchAvatarListFromCache_WithoutCache() {
        // GIVEN
        self.setUpSut()
        
        // WHEN
        let avatarListFromCache: [String: String]? = self.sut.fetchAvatarListFromCache()
        
        // THEN
        XCTAssertEqual(avatarListFromCache, nil)
    }
    
    func test_removeAvatar() {
        // GIVEN
        self.setUpSut()
        
        let avatar1 = Avatar(login: "login1", avatar_url: "url1")
        self.storage.save(avatar: avatar1)
        
        // WHEN
        self.sut.removeAvatar(avatarID: "login1")
        
        // THEN
        let avatars = self.storage.getAvatarList()
        XCTAssertEqual(0, avatars?.count)
    }
}
