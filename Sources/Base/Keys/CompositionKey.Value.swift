//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension SnapStyle {
    public struct CompositionKey: StyleKey { public init() {} }
}

extension SnapStyle.CompositionKey {


    // MARK: - Layer

    public enum Layer: CaseIterable {
        case any
        case foreground
        case background
        case backgroundOverlay
    }


    // MARK: - CompositionKey.Value

    public enum Value: StyleValue {

        public typealias WrappedValue = LayeredShapeStyle
        public typealias Adjustment = SnapStyle.CompositionKey.Adjustment

        case background(LayeredShapeStyle.LayerValue)
        case foreground(LayeredShapeStyle.LayerValue)
        case layers([Layer: LayeredShapeStyle.LayerValue])
        case composition(WrappedValue)

        public var wrappedValue: WrappedValue {
            switch self {
                case .background(let layerValue): LayeredShapeStyle([.background: layerValue])
                case .foreground(let layerValue): LayeredShapeStyle([.foreground: layerValue])
                case .layers(let valueForLayer): LayeredShapeStyle(valueForLayer)
                case .composition(let layeredShapeStyle): layeredShapeStyle
            }
        }

        public var description: String {
            "\(wrappedValue)"
        }


        // MARK: LayeredShapeStyle

        public struct LayeredShapeStyle {

            public typealias LayerValue = SnapStyle.SurfaceKey.ValueBuilderKeyPath
            typealias ShapeStyleForLayer = [Layer: LayerValue]

            let values: ShapeStyleForLayer

            public func surfaceKey(for layer: Layer) -> LayerValue? {
                values[layer] ?? values[.any]
            }

            public init(_ values: [Layer: LayerValue]) {
                self.values = values
            }

            public static func with(_ values: [Layer: LayerValue]) -> Self {
                self.init(values)
            }

        }

    }


    // MARK: - Adjustment

    public enum Adjustment: StyleAdjustment {

        public typealias Value = SnapStyle.CompositionKey.Value

        public func applied(on value: Value) -> Value {
            value
        }

    }

}
