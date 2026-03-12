//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension Style.ContextWrapper {

    /// Access a value, either from cache or by resolving the definition with the context.
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

    package func number(for keyPath: Style.Attribute.Number.ValueBuilderKeyPath?, scaled: Bool = true) -> Style.Attribute.Number.Value.WrappedValue? {

        guard let keyPath, let value = value(for: keyPath) else { return nil }

        return value.wrappedValue * (scaled ? context.scaleFactor * context.scaleDynamicType : 1)

    }

    package func cgFloat(for keyPath: Style.Attribute.Number.ValueBuilderKeyPath?, scaled: Bool = true) -> CGFloat? {

        guard let value = number(for: keyPath) else { return nil }

        return CGFloat(value)

    }


    // MARK: - Font

    package func font(for keyPath: Style.Attribute.Font.ValueBuilderKeyPath) -> Style.Attribute.Font.Value.WrappedValue? {

        let value = value(for: keyPath)

        return value?.wrappedValue

    }


    // MARK: - Icon

    package func icon(for keyPath: Style.Attribute.Icon.ValueBuilderKeyPath) -> Style.Attribute.Icon.Value.WrappedValue? {

        let value = value(for: keyPath)

        return value?.wrappedValue

    }


    // MARK: - Surface

    package func surface(for keyPath: Style.Attribute.Surface.ValueBuilderKeyPath) -> Style.Attribute.Surface.Value.WrappedValue? {

        let value = value(for: keyPath)

        return value?.wrappedValue

    }


    // MARK: - Composition

    /// Get the `LayeredShapeStyle` (aka `Composition`) for a KeyPath.
    package func composition(
        for keyPath: Style.Attribute.Composition.ValueBuilderKeyPath
    ) -> Style.Attribute.Composition.Value.LayeredShapeStyle? {

        let value = value(for: keyPath)

        return value?.wrappedValue

    }

    /// Get the Surface KeyPath of a layer for a `Composition` KeyPath.
    package func surfaceKey(
        layer: Style.Attribute.Composition.Layer,
        for keyPath: Style.Attribute.Composition.ValueBuilderKeyPath
    ) -> Style.Attribute.Composition.Value.LayeredShapeStyle.LayerValue? {

        let value = composition(for: keyPath)

        return value?.surfaceKey(for: layer)

    }

    /// Get the Surface KeyPath of a layer for a `LayeredShapeStyle` (aka `Composition`).
    package func surfaceKey(
        layer: Style.Attribute.Composition.Layer,
        composition: Style.Attribute.Composition.Value.LayeredShapeStyle
    ) -> Style.Attribute.Surface.ValueBuilderKeyPath? {

        return composition.surfaceKey(for: layer)

    }

    /// Get the surface of a layer for a `CompositionKey.ValueBuilderKeyPath`.
    package func surface(
        layer: Style.Attribute.Composition.Layer,
        for keyPath: Style.Attribute.Composition.ValueBuilderKeyPath
    ) -> Style.Attribute.Surface.Value.WrappedValue? {

        guard let layer = surfaceKey(layer: layer, for: keyPath) else { return nil }

        return surface(for: layer)

    }

    /// Get the surface of a layer for a `LayeredShapeStyle` (aka `Composition`).
    package func surface(
        layer: Style.Attribute.Composition.Layer,
        composition: Style.Attribute.Composition.Value.LayeredShapeStyle
    ) -> Style.Attribute.Surface.Value.WrappedValue? {

        guard let key = composition.surfaceKey(for: layer) else { return nil }

        return surface(for: key)

    }


    // MARK: - Accent
    
    package func accent(for keyPath: Style.Attribute.Accent.ValueBuilderKeyPath) -> Style.Attribute.Accent.Value.WrappedValue? {

        let value = value(for: keyPath)

        return value?.wrappedValue

    }
    

    // MARK: - Shape

    package func shape(for keyPath: Style.Attribute.Shape.ValueBuilderKeyPath) -> Style.Attribute.Shape.Value.WrappedValue? {

        let value = value(for: keyPath)

        return value?.wrappedValue

    }

}
