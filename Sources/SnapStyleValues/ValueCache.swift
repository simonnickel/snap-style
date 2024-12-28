//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

// TODO: Naming

extension SnapStyle {
    
    package class ValueCache<KeyType: StyleKey> {
        
        package var cachesForKeyPath: [KeyType.ValueKeyPath: ContextCache<KeyType.Value>] = [:]
        
        func getValue(for keyPath: KeyPath<KeyType, KeyType.ValueBuilder>, in context: SnapStyle.Context) -> KeyType.Value? {
            
            if let cache = cachesForKeyPath[keyPath] {
                return cache.getValue(for: context)
            }
            
            return nil
        }
        
        func setValue(_ value: KeyType.Value, for keyPath: KeyPath<KeyType, KeyType.ValueBuilder>, in context: SnapStyle.Context) {
            
            if let cache = cachesForKeyPath[keyPath] {
                cache.setValue(value, for: context)
            } else {
                let cache: ContextCache<KeyType.Value> = .init()
                cache.setValue(value, for: context)
                cachesForKeyPath[keyPath] = cache
            }
            
        }
        
    }
    
    package class ContextCache<Value> {
        
        package var valuesForContext: [SnapStyle.Context: Value] = [:]
        
        func getValue(for context: SnapStyle.Context) -> Value? {
            valuesForContext[context] ?? valuesForContext[.any]
        }
        
        func setValue(_ value: Value, for context: SnapStyle.Context) {
            valuesForContext[context] = value
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
