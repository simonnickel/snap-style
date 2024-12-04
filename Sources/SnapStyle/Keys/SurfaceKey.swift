//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension SnapStyle {
    
    public enum SurfaceKey: String, StyleKey {

        /// A key to indicate a missing value.
        case fallback

        // Keys used for `Item`.
        case title
        case content
        case label
        case value
        case cta
        case indicator
        
        // Highlight
        case interactive
        case navigation

        static func key(for item: SnapStyle.Item) -> SnapStyle.SurfaceKey {
            switch item {
                case .title: .title
                case .content: .content
                case .label: .label
                case .value: .value
                case .cta: .cta
                case .indicator: .indicator
            }
        }
    }
    
}


// MARK: - Value

extension SnapStyle.SurfaceKey {

    public enum Layer {
        case any
        case foreground
        case background
    }

    public enum Value {

        public struct ForLayer {
            
            let values: [Layer: AnyShapeStyle]

            public func surface(for layer: Layer) -> AnyShapeStyle? {
                values[layer] ?? values[.any]
            }

            public init(_ values: [Layer: AnyShapeStyle]) {
                self.values = values
            }

            public init<Foreground: ShapeStyle, Background: ShapeStyle>(foreground: Foreground, background: Background) {
                values = [.foreground: AnyShapeStyle(foreground), .background: AnyShapeStyle(background)]
            }

            public init(_ color: Color) {
                values = [.any: AnyShapeStyle(color)]
            }

            public init(foreground: Color) {
                values = [.foreground: AnyShapeStyle(foreground)]
            }

            public init(background: Color) {
                values = [.background: AnyShapeStyle(background)]
            }

        }

        case surface(ForLayer)
        case reference(SnapStyle.SurfaceKey)

        var wrappedValue: ForLayer {
            switch self {
                case .surface(let forLayer): forLayer
                case .reference(let key):
                    fatalError("A `.reference` SurfaceValue should never be used to generate a value.")
            }
        }

    }
    
}


// MARK: - SnapStyle Getter

extension SnapStyle {

    internal func surface(layer: SnapStyle.SurfaceKey.Layer, for key: SurfaceKey, in component: SnapStyle.Component, hierarchy: SnapStyle.Item.Hierarchy = .primary) -> AnyShapeStyle? {

        guard let valueBuilder = surfaces[key] else {
            return surfaces[.fallback]?(component, hierarchy)?.wrappedValue.surface(for: layer) ?? SurfaceValues.values(for: SurfaceKey.fallback)(component, hierarchy)?.wrappedValue.surface(for: layer)
        }

        let value = valueBuilder(component, hierarchy) ?? SurfaceValues.defaultValues[key]?(component, hierarchy)

        switch value {
            case .reference(let key): return surface(layer: layer, for: key, in: component, hierarchy: hierarchy)
            default: return value?.wrappedValue.surface(for: layer)
        }
    }

}
