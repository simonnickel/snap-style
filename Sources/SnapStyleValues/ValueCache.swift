//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

// TODO: Naming

extension SnapStyle {
    
    package class ValueCache<KeyType: StyleKey> {
        
        package typealias Cache = [KeyType.ValueKeyPath : ValueForContextCache<KeyType.Value>]
        
        private var content: Cache = [:]
        package var keys: Cache.Keys { content.keys }

        package func getCache(for keyPath: KeyPath<KeyType, KeyType.ValueBuilder>) -> ValueForContextCache<KeyType.Value>? {
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
    
    internal func getValueFromCache<Key: StyleKey>(for keyPath: KeyPath<Key, Key.ValueBuilder>, in context: SnapStyle.Context) -> Key.Value? {
        
        switch keyPath {
            
            case let keyPath as KeyPath<FontKey, FontKey.ValueBuilder>:
                self.cacheFonts.getValue(for: keyPath, in: context)
            
            case let keyPath as KeyPath<SurfaceKey, SurfaceKey.ValueBuilder>:
                self.cacheSurfaces.getValue(for: keyPath, in: context)

            default: fatalError("Cache is not setup properly.")

        }
        
        return nil
    }
    
    internal func setValueInCache<Key: StyleKey>(_ value: Key.Value, for keyPath: KeyPath<Key, Key.ValueBuilder>, in context: SnapStyle.Context) {
        
        switch keyPath {
            
            case let keyPath as KeyPath<FontKey, FontKey.ValueBuilder>:
                if let v = value as? FontKey.Value {
                    self.cacheFonts.setValue(v, for: keyPath, in: context)
                }
            
            case let keyPath as KeyPath<SurfaceKey, SurfaceKey.ValueBuilder>:
                if let v = value as? SurfaceKey.Value {
                    self.cacheSurfaces.setValue(v, for: keyPath, in: context)
                }
            
            default: fatalError("Cache is not setup properly.")
                
        }
    }
    
}
