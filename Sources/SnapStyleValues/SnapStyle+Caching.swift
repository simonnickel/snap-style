//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension SnapStyle {
    
    
    // MARK: - KeyTypeCache
    
    package class KeyTypeCache<KeyType: StyleKey> {
        
        package typealias Cache = [KeyType.ValueKeyPath : ValueForContextCache<KeyType.Value>]
        
        private var content: Cache = [:]
        package var keys: Cache.Keys { content.keys }

        package func getValueCache(for keyPath: KeyPath<KeyType, KeyType.ValueBuilder>) -> ValueForContextCache<KeyType.Value>? {
            return content[keyPath]
        }
        
        package func getValue(for keyPath: KeyPath<KeyType, KeyType.ValueBuilder>, in context: SnapStyle.Context) -> KeyType.Value? {
            
            if let cache = content[keyPath] {
                return cache.getValue(for: context)
            }
            
            return nil
        }
        
        func setValue(_ value: KeyType.Value, for keyPath: KeyPath<KeyType, KeyType.ValueBuilder>, in context: SnapStyle.Context) {
            
            if let cache = content[keyPath] {
                cache.setValue(value, for: context)
            } else {
                let cache: ValueForContextCache<KeyType.Value> = .init()
                cache.setValue(value, for: context)
                content[keyPath] = cache
            }
            
        }
        
    }
    
    
    // MARK: - ValueForContextCache
    
    package class ValueForContextCache<Value> {
        
        package typealias Cache = [SnapStyle.Context : Value]
        
        private var content: Cache = [:]
        package var keys: Cache.Keys { content.keys }
        
        package func getValue(for context: SnapStyle.Context) -> Value? {
            content[context] ?? content[.any]
        }
        
        func setValue(_ value: Value, for context: SnapStyle.Context) {
            content[context] = value
        }
        
    }
    
}


// MARK: - SnapStyle + Cache

extension SnapStyle {
    
    // TODO: Internal
    package func cache<KeyType>() -> KeyTypeCache<KeyType>? where KeyType: StyleKey {
        switch KeyType.self {
                
                // TODO: does casting work?
            case let key as FontKey.Type: return cacheFonts as? KeyTypeCache<KeyType>
                
            case let key as SurfaceKey.Type: return cacheSurfaces as? KeyTypeCache<KeyType>
                
            default: fatalError("Cache is not setup properly.")

        }
    }
    
    internal func getValueFromCache<Key: StyleKey>(for keyPath: KeyPath<Key, Key.ValueBuilder>, in context: SnapStyle.Context) -> Key.Value? {
        
        guard let cache: KeyTypeCache<Key> = cache() else { return nil }
        
        return cache.getValue(for: keyPath, in: context)
        
    }
    
    internal func setValueInCache<Key: StyleKey>(_ value: Key.Value, for keyPath: KeyPath<Key, Key.ValueBuilder>, in context: SnapStyle.Context) {
        
        guard let cache: KeyTypeCache<Key> = cache() else { return }

        cache.setValue(value, for: keyPath, in: context)

    }
    
}
