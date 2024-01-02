//
//  Cache.swift
//  MovieApp
//
//  Created by Daegeon Choi on 2023/08/22.
//

import Foundation

/// class for caching
final class Cache<Key: Hashable, Value> {
    
    /// Cache data Stored in this NSCache property
    private let data = NSCache<WrappedKey, Entry>()
    
    // MARK: interface methods
    
    /**
    insert new cache data
    - Parameters:
        - value:     data to insert
        - forKey:   key of data
    */
    func insertValue(_ value: Value, forKey key: Key) {
        let entry = Entry(value)
        data.setObject(entry, forKey: WrappedKey(key))
    }
    
    /**
    get cached data fot key
     - Parameter forKey: key of cached data
     - Returns: Return data for key. Returns nil when there's no matching data for key
    */
    func value(forKey key: Key) -> Value? {
        let entry = data.object(forKey: WrappedKey(key))
        return entry?.value
    }
    
    /**
    remove cached data fot key
     - Parameter forKey: key of cached data to remove
    */
    func removeValue(forKey key: Key) {
        data.removeObject(forKey: WrappedKey(key))
    }
}

// MARK: Custom Classes for NSCache
private extension Cache {
    
    /// Class to wrap public facing key for NSCache
    final class WrappedKey: NSObject {
        
        let key: Key
        
        init(_ key: Key) {
            self.key = key
        }
        
        override var hash: Int {
            return key.hashValue
        }
        
        override func isEqual(_ object: Any?) -> Bool {
            guard let value = object as? WrappedKey else { return false }
            return value.key == key
        }
    }
    
    /// Class for NSCache value
    final class Entry {
        let value: Value
        
        init(_ value: Value) {
            self.value = value
        }
    }
}

extension Cache {
    subscript(key: Key) -> Value? {
        get {
            return value(forKey: key)
        }
        
        set {
            if let value = newValue {
                insertValue(value, forKey: key)
            } else {
                // remove cached data when nil assigned
                removeValue(forKey: key)
            }
        }
    }
}
