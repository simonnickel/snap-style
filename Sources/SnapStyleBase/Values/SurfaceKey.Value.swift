//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension SnapStyle {
    public struct SurfaceKey: StyleKey { public init() {} }
}

extension SnapStyle.SurfaceKey {
    
    
    // MARK: - Layer
    
    public enum Layer {
        case any
        case foreground
        case background
    }
    
    
    // MARK: - SurfaceKey.Value

    public enum Value: StyleValue {
        
        public typealias WrappedValue = LayeredShapeStyle
        public typealias Adjustment = SnapStyle.SurfaceKey.Adjustment

        case background(LayeredShapeStyle.LayerValue)
        case foreground(LayeredShapeStyle.LayerValue)
        case layers([Layer: LayeredShapeStyle.LayerValue])
        case surface(WrappedValue)

        public static func create(with value: WrappedValue) -> Self {
            .surface(value)
        }

        public var wrappedValue: WrappedValue {
            switch self {
                case .background(let layerValue): LayeredShapeStyle([.background : layerValue])
                case .foreground(let layerValue): LayeredShapeStyle([.foreground : layerValue])
                case .layers(let valueForLayer): LayeredShapeStyle(valueForLayer)
                case .surface(let layeredShapeStyle): layeredShapeStyle
            }
        }
        
        public var description: String {
            "\(wrappedValue)"
        }
        
        
        // MARK: LayeredShapeStyle
        
        public struct LayeredShapeStyle {
            
            public typealias LayerValue = SnapStyle.ColorKey.ValueBuilderKeyPath
            typealias ShapeStyleForLayer = [Layer: LayerValue]
            
            let values: ShapeStyleForLayer
            public let ignoresSafeAreaEdges: Edge.Set
            // Respecting .horizontal safe area is necessary to allow StyleScreen to use safe area padding to inset content horizontally.
            public static let ignoresSafeAreaEdgesDefault: Edge.Set = .vertical

            public func surface(for layer: Layer) -> LayerValue? {
                values[layer] ?? values[.any]
            }

            public init(
                _ values: [Layer: LayerValue],
                ignoresSafeAreaEdges: Edge.Set = Self.ignoresSafeAreaEdgesDefault
            ) {
                self.values = values
                self.ignoresSafeAreaEdges = ignoresSafeAreaEdges
            }

            public static func with(
                _ values: [Layer: LayerValue],
                ignoresSafeAreaEdges: Edge.Set = Self.ignoresSafeAreaEdgesDefault
            ) -> Self {
                self.init(values, ignoresSafeAreaEdges: ignoresSafeAreaEdges)
            }

        }

    }


    // MARK: - Adjustment

    public enum Adjustment: StyleAdjustment {

        public typealias Value = SnapStyle.SurfaceKey.Value

        public func applied(on value: Value.WrappedValue) -> Value.WrappedValue {
            value
        }
    }

}
