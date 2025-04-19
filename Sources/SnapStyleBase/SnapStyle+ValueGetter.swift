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
    
    
    // MARK: - Color
    
    package func color(for keyPath: ColorKey.ValueBuilderKeyPath, in context: Context) -> ColorKey.Value.WrappedValue? {
        
        let value = value(for: keyPath, in: context)
        
        return value?.wrappedValue

    }

    
    // MARK: - Surface

    package func surface(
        for keyPath: SurfaceKey.ValueBuilderKeyPath,
        in context: Context
    ) -> SnapStyle.SurfaceKey.Value.LayeredShapeStyle? {
        
        let value = value(for: keyPath, in: context)

        return value?.wrappedValue

    }

    package func surface(
        layer: SurfaceKey.Layer,
        for keyPath: SurfaceKey.ValueBuilderKeyPath,
        in context: Context
    ) -> SurfaceKey.Value.LayeredShapeStyle.LayerValue? {
        
        let value = surface(for: keyPath, in: context)

        return value?.surface(for: layer)
        
    }

    /// Get the color of a layer for a `SurfaceKey.ValueBuilderKeyPath`.
    package func color(
        layer: SurfaceKey.Layer,
        for keyPath: SurfaceKey.ValueBuilderKeyPath,
        in context: Context
    ) -> ColorKey.Value.WrappedValue? {
        
        guard let layer = surface(layer: layer, for: keyPath, in: context) else { return nil }
        
        return color(for: layer, in: context)
        
    }

    /// Get the color of a layer for a `LayeredShapeStyle` (aka `Surface`).
    package func color(
        layer: SurfaceKey.Layer,
        surface: SurfaceKey.Value.LayeredShapeStyle,
        in context: Context
    ) -> ColorKey.Value.WrappedValue? {
        
        guard let layer = surface.surface(for: layer) else { return nil }
        
        return color(for: layer, in: context)
        
    }
    
    
    // MARK: - Shape

    package func shape(for keyPath: ShapeKey.ValueBuilderKeyPath, in context: Context) -> ShapeKey.Value.WrappedValue? {

        let value = value(for: keyPath, in: context)

        return value?.wrappedValue
        
    }

}
