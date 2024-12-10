//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

public struct SnapStyle {

    public var fonts: [FontKey.ValueKeyPath: ValueContainer<FontKey.Value>] = [:]
    public var surfaces: [SurfaceKey.ValueKeyPath: ValueContainer<SurfaceKey.Value>] = [:]

    private init() { }

    public static var defaults: Self {
        var style = SnapStyle()
        style.apply(FontKey.defaultKeyPaths, type: FontKey.self, at: \.fonts)
        style.apply(SurfaceKey.defaultKeyPaths, type: SurfaceKey.self, at: \.surfaces)

        return style
    }
    
    
    // MARK: - Apply
    
    mutating func apply<KeyType: StyleKey, Value, ValueKeyPath>(_ keyPaths: [ValueKeyPath], type: KeyType.Type, at destination: WritableKeyPath<SnapStyle, [ValueKeyPath: ValueContainer<Value>]>) where Value == KeyType.Value, ValueKeyPath == KeyType.ValueKeyPath {
        
        let object = type.init()
        let valueBuilderForKeyPath = Dictionary(uniqueKeysWithValues: keyPaths.map { ($0, object[keyPath: $0]) })
        
        applyWithValues(valueBuilderForKeyPath, type: type, at: destination)
        
    }
    mutating func applyWithValues<KeyType: StyleKey, Value, ValueKeyPath>(_ keyPaths: [ValueKeyPath: SnapStyle.ValueBuilder<Value>], type: KeyType.Type, at destination: WritableKeyPath<SnapStyle, [ValueKeyPath: ValueContainer<Value>]>) where Value == KeyType.Value, ValueKeyPath == KeyType.ValueKeyPath {
        for (keyPath, valueBuilder) in keyPaths {
            var values: [Context: KeyType.Value] = [:]
            var erase: [Context] = []

            var contextBuilder: SnapStyle.ValueBuilder<Value>.Builder? = nil
            switch valueBuilder {
                case .base(let value):
                    values[.any] = value
                    
                case .baseAnd(let value, context: let builder):
                    values[.any] = value
                    contextBuilder = builder

                case .context(let builder):
                    contextBuilder = builder
            }

            if let builder = contextBuilder {
                for context in Context.allCases {
                    guard keyPath == KeyType.keyPath(for: context.item.type) else { continue }
                    if let value = builder(context) {
                        if value.isErase {
                            erase.append(context)
                        } else {
                            values[context] = value
                        }
                    }
                }
            }
            
            var current = self[keyPath: destination][keyPath] ?? ValueContainer(valuesForContext: [:])
            current.erase(erase)
            current.override(with: values)
            self[keyPath: destination][keyPath] = current
        }
    }

}
