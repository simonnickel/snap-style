//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension SnapStyle {
    
    package func value<Key: StyleKey>(for keyPath: Key.ValueBuilderKeyPath, in context: SnapStyle.Context) -> Key.Value? {
        
        // Use value from cache if available
        if let value = getValueFromCache(for: keyPath, in: context) {
            return value
        }
        
        var result: Key.Value?
        let builders = builders(for: keyPath)
        
        // Build value from overrides
        for builder in builders.reversed() {
            if let buildValue = builder.value(in: context) {
                switch buildValue {
                    case .reference(let valueKeyPath):
                        result = value(for: valueKeyPath, in: context)
                    case .definition(let value):
                        result = value
                }
            }
        }
        
        // Use default value
        if result == nil {
            let defaultBuilder = Key()[keyPath: keyPath]
            if let buildValue = defaultBuilder.value(in: context) {
                switch buildValue {
                    case .reference(let valueKeyPath):
                        result = value(for: valueKeyPath, in: context)
                    case .definition(let value):
                        result = value
                }
            }
        }
        
        // Store result in cache
        if let result {
            setValueInCache(result, for: keyPath, in: context)
        }
        
        return result
    }
    
    private func builders<Key: StyleKey>(for keyPath: Key.ValueBuilderKeyPath) -> [Key.ValueBuilder] {
        
        switch keyPath {
            
            case let keyPath as KeyPath<NumberKey, NumberKey.ValueBuilder>:
                if let builders = self.numbers[keyPath] as? [Key.ValueBuilder] {
                    return builders
                }
                
            case let keyPath as KeyPath<FontKey, FontKey.ValueBuilder>:
                if let builders = self.fonts[keyPath] as? [Key.ValueBuilder] {
                    return builders
                }
            
            case let keyPath as KeyPath<ColorKey, ColorKey.ValueBuilder>:
                if let builders = self.colors[keyPath] as? [Key.ValueBuilder] {
                    return builders
                }
            
            case let keyPath as KeyPath<SurfaceKey, SurfaceKey.ValueBuilder>:
                if let builders = self.surfaces[keyPath] as? [Key.ValueBuilder] {
                    return builders
                }
            
            default: fatalError("Not defined for \(Key.self)")
                
        }
        
        return []
    }
    
    
    // MARK: - Number
    
    package func number(for keyPath: NumberKey.ValueBuilderKeyPath, in context: SnapStyle.Context) -> NumberKey.Value.WrappedValue? {
        
        let value = value(for: keyPath, in: context)
        
        // TODO: Scaling?

        return value?.wrappedValue
        
    }
    
    
    // MARK: - Font
    
    package func font(for keyPath: FontKey.ValueBuilderKeyPath, in context: SnapStyle.Context) -> FontKey.Value.WrappedValue? {
        
        let value = value(for: keyPath, in: context)
        
        // TODO: Font scaling?

        return value?.wrappedValue
        
    }
    
    
    // MARK: - Color
    
    package func color(for keyPath: ColorKey.ValueBuilderKeyPath, in context: Context) -> Color? {
        
        let value = value(for: keyPath, in: context)
        
        return value?.wrappedValue
        
    }

    
    // MARK: - Surface

    // TODO: return type
    package func surface(layer: SnapStyle.SurfaceKey.Layer, for keyPath: SurfaceKey.ValueBuilderKeyPath, in context: Context) -> SnapStyle.SurfaceKey.Value.LayeredShapeStyle.LayerValue? {
        let value = value(for: keyPath, in: context)

        return value?.wrappedValue.surface(for: layer)
        
    }

}
