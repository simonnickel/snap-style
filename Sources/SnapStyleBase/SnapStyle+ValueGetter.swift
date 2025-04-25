//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension SnapStyle {
    
    package func value<Key: StyleKey>(for keyPath: Key.ValueBuilderKeyPath, with adjustments: [Key.Value.Adjustment] = [], in context: SnapStyle.Context) -> Key.Value? {

        // Use value from cache if available
        if let value = getValueFromCache(for: keyPath, in: context) {
            return value
        }
        
        var result: Key.Value?
        let builders = builderContainer.builder(for: keyPath)
        
        // Build value from overrides
        for builder in builders.reversed() {
            if let buildValue = builder.value(in: context) {
                switch buildValue {
                    case .reference(let valueKeyPath, let adjustments):
                        result = value(for: valueKeyPath, with: adjustments, in: context)
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
                    case .reference(let valueKeyPath, let adjustments):
                        result = value(for: valueKeyPath, with: adjustments, in: context)
                    case .definition(let value):
                        result = value
                }
            }
        }

        // Apply Adjustments
        result = result?.value(with: adjustments)

        // Store result in cache
        if let result {
            setValueInCache(result, for: keyPath, in: context)
        }
        
        return result
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
    
    
    // MARK: - Surface
    
    package func surface(for keyPath: SurfaceKey.ValueBuilderKeyPath, in context: Context) -> SurfaceKey.Value.WrappedValue? {
        
        let value = value(for: keyPath, in: context)
        
        return value?.wrappedValue

    }

    
    // MARK: - Composition

    package func composition(
        for keyPath: CompositionKey.ValueBuilderKeyPath,
        in context: Context
    ) -> SnapStyle.CompositionKey.Value.LayeredShapeStyle? {
        
        let value = value(for: keyPath, in: context)

        return value?.wrappedValue

    }

    package func composition(
        layer: CompositionKey.Layer,
        for keyPath: CompositionKey.ValueBuilderKeyPath,
        in context: Context
    ) -> CompositionKey.Value.LayeredShapeStyle.LayerValue? {
        
        let value = composition(for: keyPath, in: context)

        return value?.surfaceKey(for: layer)
        
    }

    /// Get the surface of a layer for a `CompositionKey.ValueBuilderKeyPath`.
    package func surface(
        layer: CompositionKey.Layer,
        for keyPath: CompositionKey.ValueBuilderKeyPath,
        in context: Context
    ) -> SurfaceKey.Value.WrappedValue? {
        
        guard let layer = composition(layer: layer, for: keyPath, in: context) else { return nil }
        
        return surface(for: layer, in: context)
        
    }

    /// Get the surface of a layer for a `LayeredShapeStyle` (aka `Composition`).
    package func surface(
        layer: CompositionKey.Layer,
        composition: CompositionKey.Value.LayeredShapeStyle,
        in context: Context
    ) -> SurfaceKey.Value.WrappedValue? {
        
        guard let key = composition.surfaceKey(for: layer) else { return nil }
        
        return surface(for: key, in: context)
        
    }
    
    
    // MARK: - Shape

    package func shape(for keyPath: ShapeKey.ValueBuilderKeyPath, in context: Context) -> ShapeKey.Value.WrappedValue? {

        let value = value(for: keyPath, in: context)

        return value?.wrappedValue
        
    }

}
