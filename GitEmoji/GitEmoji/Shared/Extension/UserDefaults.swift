//
//  UserDefaults.swift
//  GitEmoji
//
//  Created by Wellington Bezerra on 12/1/22.
//

import Foundation

public protocol ObjectSavable {
    func setObject<Object: Encodable>(_ object: Object, forKey key: String) throws
    func getObject<Object: Decodable>(_ type: Object.Type, forKey key: String) throws -> Object
    func resetTopLevelObject(forKey key: String)
}

extension UserDefaults: ObjectSavable {

    public func setObject<Object: Encodable>(_ object: Object, forKey key: String) throws {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            self.setValue(data, forKey: key)
        } catch {
            throw error
        }
    }
    
    public func getObject<Object: Decodable>(_ type: Object.Type, forKey key: String) throws -> Object {
        guard let data = self.data(forKey: key) else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: "No value"))
        }
        let decoder = JSONDecoder()
        return try decoder.decode(type, from: data)
    }

    public func resetTopLevelObject(forKey key: String) {
        self.removeObject(forKey: key)
    }
}
