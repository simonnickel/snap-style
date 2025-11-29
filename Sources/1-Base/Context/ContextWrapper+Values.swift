//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension Style.ContextWrapper {

    package typealias Attributes = Style.Attributes

    package func value<Attribute: StyleAttribute>(for keyPath: Attribute.ValueBuilderKeyPath, with adjustments: [Attribute.Value.Adjustment] = []) -> Attribute.Value? {

        // Use value from cache if available
        if let value = definition.getValueFromCache(for: keyPath, in: context) {
            return value.adjusted(with: adjustments)
        }

        var result: Attribute.Value?
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
            let defaultBuilder = Attribute()[keyPath: keyPath]
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

    package func number(for keyPath: Attributes.Number.ValueBuilderKeyPath?, scaled: Bool = true) -> Attributes.Number.Value.WrappedValue? {

        guard let keyPath, let value = value(for: keyPath) else { return nil }

        return value.wrappedValue * (scaled ? context.scaleFactor * context.scaleDynamicType : 1)

    }

    package func cgFloat(for keyPath: Attributes.Number.ValueBuilderKeyPath?, scaled: Bool = true) -> CGFloat? {

        guard let value = number(for: keyPath) else { return nil }

        return CGFloat(value)

    }


    // MARK: - Font

    package func font(for keyPath: Attributes.Font.ValueBuilderKeyPath) -> Attributes.Font.Value.WrappedValue? {

        let value = value(for: keyPath)

        return value?.wrappedValue

    }


    // MARK: - Icon

    package func icon(for keyPath: Attributes.Icon.ValueBuilderKeyPath) -> Attributes.Icon.Value.WrappedValue? {

        let value = value(for: keyPath)

        return value?.wrappedValue

    }


    // MARK: - Surface

    package func surface(for keyPath: Attributes.Surface.ValueBuilderKeyPath) -> Attributes.Surface.Value.WrappedValue? {

        let value = value(for: keyPath)

        return value?.wrappedValue

    }


    // MARK: - Composition

    /// Get the `LayeredShapeStyle` (aka `Composition`) for a KeyPath.
    package func composition(
        for keyPath: Attributes.Composition.ValueBuilderKeyPath
    ) -> Style.Attributes.Composition.Value.LayeredShapeStyle? {

        let value = value(for: keyPath)

        return value?.wrappedValue

    }

    /// Get the Surface KeyPath of a layer for a `Composition` KeyPath.
    package func surfaceKey(
        layer: Attributes.Composition.Layer,
        for keyPath: Attributes.Composition.ValueBuilderKeyPath
    ) -> Attributes.Composition.Value.LayeredShapeStyle.LayerValue? {

        let value = composition(for: keyPath)

        return value?.surfaceKey(for: layer)

    }

    /// Get the Surface KeyPath of a layer for a `LayeredShapeStyle` (aka `Composition`).
    package func surfaceKey(
        layer: Attributes.Composition.Layer,
        composition: Attributes.Composition.Value.LayeredShapeStyle
    ) -> Attributes.Surface.ValueBuilderKeyPath? {

        return composition.surfaceKey(for: layer)

    }

    /// Get the surface of a layer for a `CompositionKey.ValueBuilderKeyPath`.
    package func surface(
        layer: Attributes.Composition.Layer,
        for keyPath: Attributes.Composition.ValueBuilderKeyPath
    ) -> Attributes.Surface.Value.WrappedValue? {

        guard let layer = surfaceKey(layer: layer, for: keyPath) else { return nil }

        return surface(for: layer)

    }

    /// Get the surface of a layer for a `LayeredShapeStyle` (aka `Composition`).
    package func surface(
        layer: Attributes.Composition.Layer,
        composition: Attributes.Composition.Value.LayeredShapeStyle
    ) -> Attributes.Surface.Value.WrappedValue? {

        guard let key = composition.surfaceKey(for: layer) else { return nil }

        return surface(for: key)

    }


    // MARK: - Accent
    
    package func accent(for keyPath: Attributes.Accent.ValueBuilderKeyPath) -> Attributes.Accent.Value.WrappedValue? {

        let value = value(for: keyPath)

        return value?.wrappedValue

    }
    

    // MARK: - Shape

    package func shape(for keyPath: Attributes.Shape.ValueBuilderKeyPath) -> Attributes.Shape.Value.WrappedValue? {

        let value = value(for: keyPath)

        return value?.wrappedValue

    }

}
