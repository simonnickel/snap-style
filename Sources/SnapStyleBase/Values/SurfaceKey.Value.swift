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

        case surface(WrappedValue)

        public static func create(with value: WrappedValue) -> Self {
            .surface(value)
        }

        public var wrappedValue: WrappedValue {
            switch self {
                case .surface(let forLayer): forLayer
            }
        }
        
        public var description: String {
            switch self {
                case .surface(let definition): ".definition: \(definition)"
            }
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

            public init(
                foreground: LayerValue? = nil,
                background: LayerValue? = nil,
                ignoresSafeAreaEdges: Edge.Set = Self.ignoresSafeAreaEdgesDefault
            ) {
                var values: ShapeStyleForLayer = [:]
                if let foreground {
                    values[.foreground] = foreground
                }
                if let background {
                    values[.background] = background
                }
                
                self.init(values, ignoresSafeAreaEdges: ignoresSafeAreaEdges)
            }

            public static func with(
                foreground: LayerValue? = nil,
                background: LayerValue? = nil,
                ignoresSafeAreaEdges: Edge.Set = Self.ignoresSafeAreaEdgesDefault
            ) -> Self {
                self.init(foreground: foreground, background: background, ignoresSafeAreaEdges: ignoresSafeAreaEdges)
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
