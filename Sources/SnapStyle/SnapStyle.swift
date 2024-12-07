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
            var values: [Context: FontKey.Value] = [:]
            var erase: [Context] = []

            if let base = valueBuilder.base {
                values[.any] = base
            }

            if let builder = valueBuilder.context {
                for context in Context.allCases {
                    guard key == FontKey.key(for: context.item.type) else { continue }
                    if let value = builder(context) {
                        if case .erase = value {
                            erase.append(context)
                        } else {
                            values[context] = value
                        }
                    }
                }
            }

            var current = fonts[key] ?? Values(valuesForContext: [:])
            current.erase(erase)
            current.override(with: values)
            fonts[key] = current
        }
    }

    mutating func apply(surfaceBuilder: [SurfaceKey: SnapStyle.ValueBuilder<SurfaceKey.Value>]) {
        for (key, valueBuilder) in surfaceBuilder {
            var values: [Context: SurfaceKey.Value] = [:]
            var erase: [Context] = []

            if let base = valueBuilder.base {
                values[.any] = base
            }

            if let builder = valueBuilder.context {
                for context in Context.allCases {
                    guard key == SurfaceKey.key(for: context.item.type) else { continue }
                    if let value = builder(context) {
                        if case .erase = value {
                            erase.append(context)
                        } else {
                            values[context] = value
                        }
                    }
                }
            }

            var current = surfaces[key] ?? Values(valuesForContext: [:])
//            current.erase(erase)
            current.override(with: values)
            surfaces[key] = current
        }
    }

}

extension SnapStyle {

    internal struct Values<Value> {
        public var valuesForContext: [SnapStyle.Context: Value]

        func value(for context: SnapStyle.Context) -> Value? {
            valuesForContext[context] ?? valuesForContext[.any]
        }

        mutating func override(with overrides: [SnapStyle.Context: Value]) {
            for (context, value) in overrides {
                valuesForContext[context] = value
            }
        }

        mutating func erase(_ contexts: [SnapStyle.Context]) {
            for context in contexts {
                valuesForContext.removeValue(forKey: context)
            }
        }
    }

}
