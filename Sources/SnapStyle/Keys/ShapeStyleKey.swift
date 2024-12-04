//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension SnapStyle {
    
    public enum ShapeStyleKey: String, StyleKey {

        /// A key to indicate a missing value.
        case fallback

        // Item
        case title
        case content
        case label
        case value
        case cta
        case indicator
        
        // Highlight
        case interactive
        case navigation
    }
    
}

extension SnapStyle.ShapeStyleKey {

    public enum Layer {
        case any
        case foreground
        case background
    }

    public enum Value {

        public struct Set {
            let valuesForLayers: [Layer: AnyShapeStyle]

            public func shapeStyle(for layer: Layer) -> AnyShapeStyle? {
                valuesForLayers[layer] ?? valuesForLayers[.any]
            }

            public init(_ values: [Layer: AnyShapeStyle]) {
                valuesForLayers = values
            }

            public init<Foreground: ShapeStyle, Background: ShapeStyle>(foreground: Foreground, background: Background) {
                valuesForLayers = [.foreground : AnyShapeStyle(foreground), .background : AnyShapeStyle(background)]
            }

            public init(_ color: Color) {
                valuesForLayers = [.any: AnyShapeStyle(color)]
            }
            
            public init(_ shapeStyle: any ShapeStyle) {
                valuesForLayers = [.any: AnyShapeStyle(shapeStyle)]
            }

            public init(foreground: Color) {
                valuesForLayers = [.foreground: AnyShapeStyle(foreground)]
            }

            public init(background: Color) {
                valuesForLayers = [.background: AnyShapeStyle(background)]
            }

            public init(foreground: any ShapeStyle) {
                valuesForLayers = [.foreground: AnyShapeStyle(foreground)]
            }

            public init(background: any ShapeStyle) {
                valuesForLayers = [.background: AnyShapeStyle(background)]
            }
        }

        case set(Set)
        case reference(SnapStyle.ShapeStyleKey)

        var wrappedValue: Set {
            switch self {
                case .set(let set): set
                case .reference(let key):
                    fatalError("A `.reference` ColorValue should never be used to generate a value.")
            }
        }

    }
    
}
