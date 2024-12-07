//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

public struct SnapStyle {

    internal var fonts: [FontKey: Values<FontKey.Value>] = [:]
    internal var surfaces: [SurfaceKey: Values<SurfaceKey.Value>] = [:]

    private init() { }

    public static var defaults: Self {
        var style = SnapStyle()
        style.apply(fontBuilder: FontValues.defaultValues)
        style.apply(surfaceBuilder: SurfaceValues.defaultValues)

        return style
    }

    mutating func apply(fontBuilder: [FontKey: SnapStyle.ValueBuilder<FontKey.Value>]) {
        for (key, valueBuilder) in fontBuilder {
            let values: [Context: FontKey.Value] = Dictionary(uniqueKeysWithValues: Context.allCases.compactMap { context in
                guard let value = valueBuilder(context) else { return nil }
                return (context, value)
            })
            var current = fonts[key] ?? Values(valuesForContext: [:])
            current.override(with: values)
            fonts[key] = current
        }
    }

    mutating func apply(surfaceBuilder: [SurfaceKey: SnapStyle.ValueBuilder<SurfaceKey.Value>]) {
        for (key, valueBuilder) in surfaceBuilder {
            let values: [Context: SurfaceKey.Value] = Dictionary(uniqueKeysWithValues: Context.allCases.compactMap { context in
                guard let value = valueBuilder(context) else { return nil }
                return (context, value)
            })
            var current = surfaces[key] ?? Values(valuesForContext: [:])
            current.override(with: values)
            surfaces[key] = current
        }
    }

}

extension SnapStyle {

    internal struct Values<Value> {
        public var valuesForContext: [SnapStyle.Context: Value]

        func value(for context: SnapStyle.Context) -> Value? {
            valuesForContext[context]
        }

        mutating func override(with overrides: [SnapStyle.Context: Value]) {
            for (context, value) in overrides {
                valuesForContext[context] = value
            }
        }
    }

}
