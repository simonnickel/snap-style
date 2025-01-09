//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension SnapStyle {
    
    
    // MARK: - KeyTypeCache
    
    package class KeyTypeCache<Key: StyleKey> {
        
        private var content: [Key.ValueKeyPath : ValueForContextCache<Key.Value>] = [:]
        package var keys: [Key.ValueKeyPath] { Array(content.keys) }

        package func getValueCache(for keyPath: KeyPath<Key, Key.ValueBuilder>) -> ValueForContextCache<Key.Value>? {
            return content[keyPath]
        }
        
        package func getValue(for keyPath: KeyPath<Key, Key.ValueBuilder>, in context: SnapStyle.Context) -> Key.Value? {
            
            if let cache = content[keyPath] {
                return cache.getValue(for: context)
            }
            
            return nil
        }
        
        func setValue(_ value: Key.Value, for keyPath: KeyPath<Key, Key.ValueBuilder>, in context: SnapStyle.Context) {
            
            if let cache = content[keyPath] {
                cache.setValue(value, for: context)
            } else {
                let cache: ValueForContextCache<Key.Value> = .init()
                cache.setValue(value, for: context)
                content[keyPath] = cache
            }
            
        }
        
    }
    
    
    // MARK: - ValueForContextCache
    
    package class ValueForContextCache<Value> {
        
        private var content: [SnapStyle.Context : Value] = [:]
        package var keys: [SnapStyle.Context] { Array(content.keys) }
        
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
    
    /// For debug purposes.
    package func cachedKeyPaths<Key: StyleKey>(for: Key.Type) -> [Key.ValueKeyPath] {
        guard
            let cache: KeyTypeCache<Key> = cache()
        else { return [] }
        
        return cache.keys
    }
    
    /// For debug purposes.
    package func cachedContexts<Key: StyleKey>(for keyPath: Key.ValueKeyPath) -> [SnapStyle.Context] {
        guard
            let cache: KeyTypeCache<Key> = cache(),
            let valueCache = cache.getValueCache(for: keyPath)
        else { return [] }

        return valueCache.keys
    }
    
    /// For debug purposes.
    package func cachedValue<Key: StyleKey>(for keyPath: Key.ValueKeyPath, in context: SnapStyle.Context) -> Key.Value? {
        guard
            let cache: KeyTypeCache<Key> = cache(),
            let valueCache = cache.getValueCache(for: keyPath)
        else { return nil }

        return valueCache.getValue(for: context)
    }
    
    internal func cache<Key: StyleKey>() -> KeyTypeCache<Key>? {
        switch Key.self {
                
            case let key as FontKey.Type: return cacheFonts as? KeyTypeCache<Key>
                
            case let key as SurfaceKey.Type: return cacheSurfaces as? KeyTypeCache<Key>
                
            default: fatalError("Cache is not setup properly.")

        }
    }
    
    internal func getValueFromCache<Key: StyleKey>(for keyPath: Key.ValueKeyPath, in context: SnapStyle.Context) -> Key.Value? {
        
        guard let cache: KeyTypeCache<Key> = cache() else { return nil }
        
        return cache.getValue(for: keyPath, in: context)
        
    }
    
    internal func setValueInCache<Key: StyleKey>(_ value: Key.Value, for keyPath: KeyPath<Key, Key.ValueBuilder>, in context: SnapStyle.Context) {
        
        guard let cache: KeyTypeCache<Key> = cache() else { return }

        cache.setValue(value, for: keyPath, in: context)

    }
    
}
