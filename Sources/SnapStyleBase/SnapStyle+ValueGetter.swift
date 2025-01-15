//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension SnapStyle {
    
    package func value<Key: StyleKey>(for keyPath: KeyPath<Key, Key.ValueBuilder>, in context: SnapStyle.Context) -> Key.Value? {
        
        // Use value from cache if available
        if let value = getValueFromCache(for: keyPath, in: context) {
            return value
        }
        
        var result: Key.Value?
        let builders = builders(for: keyPath)
        
        // Build value from overrides
        for builder in builders.reversed() {
            if let value = builder.value(in: context) {
                result = value
            }
        }
        
        // Use default value
        if result == nil {
            let defaultBuilder = Key()[keyPath: keyPath]
            result = defaultBuilder.value(in: context)
        }
        
        // Store result in cache
        if let result {
            setValueInCache(result, for: keyPath, in: context)
        }
        
        return result
    }
    
    private func builders<Key: StyleKey>(for keyPath: KeyPath<Key, Key.ValueBuilder>) -> [Key.ValueBuilder] {
        
        switch keyPath {
            
            case let keyPath as KeyPath<FontKey, FontKey.ValueBuilder>:
                if let builders = self.fonts[keyPath] as? [Key.ValueBuilder] {
                    return builders
                }
            
            case let keyPath as KeyPath<SurfaceKey, SurfaceKey.ValueBuilder>:
                if let builders = self.surfaces[keyPath] as? [Key.ValueBuilder] {
                    return builders
                }
            
            default: return []
                
        }
        
        return []
    }
    
    
    // MARK: - Font
    
    package func font(for keyPath: FontKey.ValueKeyPath, in context: SnapStyle.Context) -> FontKey.Value.WrappedValue? {
        
        let value = value(for: keyPath, in: context)

        switch value {
            case .reference(let key): return font(for: key, in: context)
            default: return value?.wrappedValue
        }
        
    }

    
    // MARK: - Surface
    
    package func surface(layer: SnapStyle.SurfaceKey.Layer, for keyPath: SurfaceKey.ValueKeyPath, in context: Context) -> AnyShapeStyle? {

        let value = value(for: keyPath, in: context)

        switch value {
            case .reference(let key): return surface(layer: layer, for: key, in: context)
            default: return value?.wrappedValue.surface(for: layer)
        }
        
    }

}
