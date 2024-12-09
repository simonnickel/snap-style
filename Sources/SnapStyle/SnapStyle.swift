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
        style.apply(FontValues.defaultValues, at: \.fonts)
        style.apply(SurfaceValues.defaultValues, at: \.surfaces)

        return style
    }
    
    mutating func apply<KeyType: StyleKey>(_ builder: [KeyType: SnapStyle.ValueBuilder<KeyType.Value>], at keyPath: WritableKeyPath<SnapStyle, [KeyType: Values<KeyType.Value>]>) {
        for (key, valueBuilder) in builder {
            var values: [Context: KeyType.Value] = [:]
            var erase: [Context] = []

            if let base = valueBuilder.base {
                values[.any] = base
            }

            if let builder = valueBuilder.context {
                for context in Context.allCases {
                    guard key == KeyType.key(for: context.item.type) else { continue }
                    if let value = builder(context) {
                        if KeyType.isErase(value) {
                            erase.append(context)
                        } else {
                            values[context] = value
                        }
                    }
                }
            }
            
            var current = self[keyPath: keyPath][key] ?? Values(valuesForContext: [:])
            current.erase(erase)
            current.override(with: values)
            self[keyPath: keyPath][key] = current
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
