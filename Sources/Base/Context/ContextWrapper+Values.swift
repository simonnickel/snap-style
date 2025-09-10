//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension Style.ContextWrapper {

    package typealias NumberKey = Style.Keys.NumberKey
    package typealias FontKey = Style.Keys.FontKey
    package typealias IconKey = Style.Keys.IconKey
    package typealias SurfaceKey = Style.Keys.SurfaceKey
    package typealias CompositionKey = Style.Keys.CompositionKey
    package typealias AccentKey = Style.Keys.AccentKey
    package typealias ShapeKey = Style.Keys.ShapeKey

    package func value<Key: StyleKey>(for keyPath: Key.ValueBuilderKeyPath, with adjustments: [Key.Value.Adjustment] = []) -> Key.Value? {

        // Use value from cache if available
        if let value = definition.getValueFromCache(for: keyPath, in: context) {
            return value.adjusted(with: adjustments)
        }

        var result: Key.Value?
        let builders = definition.builderContainer.builder(for: keyPath)

        // Build value from overrides
        for builder in builders {
            if let buildValue = builder.value(in: self) {
                switch buildValue {
                    case .reference(let valueKeyPath, let adjustments):
                        result = value(for: valueKeyPath, with: adjustments)
                    case .definition(let value):
                        result = value
                }
            }
        }

        // Use default value
        if result == nil {
            let defaultBuilder = Key()[keyPath: keyPath]
            if let buildValue = defaultBuilder.value(in: self) {
                switch buildValue {
                    case .reference(let valueKeyPath, let adjustments):
                        result = value(for: valueKeyPath, with: adjustments)
                    case .definition(let value):
                        result = value
                }
            }
        }

        // Store result in cache
        if let result {
            definition.setValueInCache(result, for: keyPath, in: context)
        }

        // Apply Adjustments
        result = result?.adjusted(with: adjustments)

        return result
    }


    // MARK: - Number

    package func number(for keyPath: NumberKey.ValueBuilderKeyPath?, scaled: Bool = true) -> NumberKey.Value.WrappedValue? {

        guard let keyPath, let value = value(for: keyPath) else { return nil }

        return value.wrappedValue * (scaled ? context.scaleFactor : 1)

    }

    package func cgFloat(for keyPath: NumberKey.ValueBuilderKeyPath?, scaled: Bool = true) -> CGFloat? {

        guard let value = number(for: keyPath) else { return nil }

        return CGFloat(value)
    }


    // MARK: - Font

    package func font(for keyPath: FontKey.ValueBuilderKeyPath) -> FontKey.Value.WrappedValue? {

        let value = value(for: keyPath)

        return value?.wrappedValue

    }


    // MARK: - Icon

    package func icon(for keyPath: IconKey.ValueBuilderKeyPath) -> IconKey.Value.WrappedValue? {

        let value = value(for: keyPath)

        return value?.wrappedValue

    }


    // MARK: - Surface

    package func surface(for keyPath: SurfaceKey.ValueBuilderKeyPath) -> SurfaceKey.Value.WrappedValue? {

        let value = value(for: keyPath)

        return value?.wrappedValue

    }


    // MARK: - Composition

    /// Get the `LayeredShapeStyle` (aka `Composition`) for a KeyPath.
    package func composition(
        for keyPath: CompositionKey.ValueBuilderKeyPath
    ) -> Style.Keys.CompositionKey.Value.LayeredShapeStyle? {

        let value = value(for: keyPath)

        return value?.wrappedValue

    }

    /// Get the Surface KeyPath of a layer for a `Composition` KeyPath.
    package func surfaceKey(
        layer: CompositionKey.Layer,
        for keyPath: CompositionKey.ValueBuilderKeyPath
    ) -> CompositionKey.Value.LayeredShapeStyle.LayerValue? {

        let value = composition(for: keyPath)

        return value?.surfaceKey(for: layer)

    }

    /// Get the Surface KeyPath of a layer for a `LayeredShapeStyle` (aka `Composition`).
    package func surfaceKey(
        layer: CompositionKey.Layer,
        composition: CompositionKey.Value.LayeredShapeStyle
    ) -> SurfaceKey.ValueBuilderKeyPath? {

        return composition.surfaceKey(for: layer)

    }

    /// Get the surface of a layer for a `CompositionKey.ValueBuilderKeyPath`.
    package func surface(
        layer: CompositionKey.Layer,
        for keyPath: CompositionKey.ValueBuilderKeyPath
    ) -> SurfaceKey.Value.WrappedValue? {

        guard let layer = surfaceKey(layer: layer, for: keyPath) else { return nil }

        return surface(for: layer)

    }

    /// Get the surface of a layer for a `LayeredShapeStyle` (aka `Composition`).
    package func surface(
        layer: CompositionKey.Layer,
        composition: CompositionKey.Value.LayeredShapeStyle
    ) -> SurfaceKey.Value.WrappedValue? {

        guard let key = composition.surfaceKey(for: layer) else { return nil }

        return surface(for: key)

    }


    // MARK: - Accent
    
    package func accent(for keyPath: AccentKey.ValueBuilderKeyPath) -> AccentKey.Value.WrappedValue? {

        let value = value(for: keyPath)

        return value?.wrappedValue

    }
    

    // MARK: - Shape

    package func shape(for keyPath: ShapeKey.ValueBuilderKeyPath) -> ShapeKey.Value.WrappedValue? {

        let value = value(for: keyPath)

        return value?.wrappedValue

    }

}
