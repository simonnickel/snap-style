//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

public struct SnapStyle {

    public var fonts: [FontKey.ValueKeyPath: Values<FontKey.Value>] = [:]
    public var surfaces: [SurfaceKey.ValueKeyPath: Values<SurfaceKey.Value>] = [:]

    private init() { }

    public static var defaults: Self {
        var style = SnapStyle()
        style.apply(FontKey.defaultKeyPaths, type: FontKey.self, at: \.fonts)
        style.apply(SurfaceKey.defaultKeyPaths, type: SurfaceKey.self, at: \.surfaces)

        return style
    }
    
    mutating func apply<KeyType: StyleKey, Value, ValueKeyPath>(_ keyPaths: [ValueKeyPath], type: KeyType.Type, at destination: WritableKeyPath<SnapStyle, [ValueKeyPath: Values<Value>]>) where Value == KeyType.Value, ValueKeyPath == KeyType.ValueKeyPath {
        
        let object = type.init()
        let valueBuilderForKeyPath = Dictionary(uniqueKeysWithValues: keyPaths.map { ($0, object[keyPath: $0]) })
        
        applyWithValues(valueBuilderForKeyPath, type: type, at: destination)
        
    }
    mutating func applyWithValues<KeyType: StyleKey, Value, ValueKeyPath>(_ keyPaths: [ValueKeyPath: SnapStyle.ValueBuilder<Value>], type: KeyType.Type, at destination: WritableKeyPath<SnapStyle, [ValueKeyPath: Values<Value>]>) where Value == KeyType.Value, ValueKeyPath == KeyType.ValueKeyPath {
        for (keyPath, valueBuilder) in keyPaths {
            var values: [Context: KeyType.Value] = [:]
            var erase: [Context] = []

            if let base = valueBuilder.base {
                values[.any] = base
            }

            if let builder = valueBuilder.context {
                for context in Context.allCases {
                    guard keyPath == KeyType.keyPath(for: context.item.type) else { continue }
                    if let value = builder(context) {
                        if KeyType.isErase(value) {
                            erase.append(context)
                        } else {
                            values[context] = value
                        }
                    }
                }
            }
            
            var current = self[keyPath: destination][keyPath] ?? Values(valuesForContext: [:])
            current.erase(erase)
            current.override(with: values)
            self[keyPath: destination][keyPath] = current
        }
    }

}

extension SnapStyle {

    public struct Values<Value> {
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
