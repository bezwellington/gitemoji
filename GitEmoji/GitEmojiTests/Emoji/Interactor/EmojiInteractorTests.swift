//
//  EmojiInteractorTests.swift
//  GitEmojiTests
//
//  Created by Wellington on 05/12/22.
//

import XCTest
@testable import GitEmoji

final class EmojiInteractorTests: XCTestCase {

    private var sut: EmojiInteractor!
    private var storage: EmojiStorageMock!
    private var adapter: EmojiAdapterMock!
    private var delegate: EmojiInteractorDelegateMock!
    
    override func setUp() {
        super.setUp()
    }

    private func setUpSut() {
        self.storage = EmojiStorageMock()
        self.adapter = EmojiAdapterMock()
        self.delegate = EmojiInteractorDelegateMock()
        
        self.sut = EmojiInteractor(adapter: self.adapter, storage: self.storage)
        
        self.sut.setUp(delegate: self.delegate)
    }
    
    func test_fetchEmojiList_FromCache() {

        // GIVEN
        self.setUpSut()

        let emojiID = "avatarID"
        let emoji = [emojiID: "url"]
        self.storage.save(emojiList: emoji)

        // WHEN
        self.sut.fetchEmojiList()

        // THEN
        let emojiList = self.storage.getEmojiList()
        XCTAssertEqual(emojiList?.count, 1)
        XCTAssertEqual(self.delegate.methods, [.didFetchEmojiList])
        XCTAssertEqual(self.delegate.emojis, emoji)
        XCTAssertEqual(self.adapter.methods, [.setUpDelegate])
    }

    func test_fetchEmojiList_FromServer_WithSuccess() {
        // GIVEN
        self.setUpSut()
        
        let emoji = ["id": "url"]
        self.adapter.emojis = emoji
        self.adapter.isSuccess = true
        
        // WHEN
        self.sut.fetchEmojiList()
        
        // THEN
        XCTAssertEqual(self.delegate.methods, [.didFetchEmojiList])
        XCTAssertEqual(self.delegate.emojis, emoji)
        XCTAssertEqual(self.adapter.methods, [.setUpDelegate, .fetchEmojiList])
    }
    
    func test_fetchEmojiList_FromServer_WithError() {
        // GIVEN
        self.setUpSut()
        
        self.adapter.isSuccess = false
        
        // WHEN
        self.sut.fetchEmojiList()
        
        // THEN
        XCTAssertEqual(self.delegate.methods, [.didNotFetchEmojiList])
        XCTAssertEqual(self.delegate.emojis, nil)
        XCTAssertEqual(self.adapter.methods, [.setUpDelegate, .fetchEmojiList])
    }
    
    func test_fetchEmojiListFromCache_WithCache() {
        // GIVEN
        self.setUpSut()
        
        let emojiList = ["id1": "url1", "id2": "url2"]
        self.storage.save(emojiList: emojiList)
       
        // WHEN
        let emojiListFromCache = self.sut.fetchEmojiListFromCache()
        
        // THEN
        XCTAssertEqual(emojiList.count, emojiListFromCache?.count)
    }

    func test_fetchEmojiListFromCache_WithoutCache() {
        // GIVEN
        self.setUpSut()
        
        // WHEN
        let emojiListFromCache: [String: String]? = self.sut.fetchEmojiListFromCache()
        
        // THEN
        XCTAssertEqual(emojiListFromCache, nil)
    }
    
    func test_getRandomEmojiImageURL() {
        // GIVEN
        self.setUpSut()
        
        // WHEN
        self.sut.getRandomEmojiImageURL()
        
        // THEN
        XCTAssertEqual(self.delegate.methods, [.didGetRandomEmojiImage])
    }
}
