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

        case surface(WrappedValue)

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
            
            typealias ShapeStyleForLayer = [Layer: AnyShapeStyle]
            
            let values: ShapeStyleForLayer

            public func surface(for layer: Layer) -> AnyShapeStyle? {
                values[layer] ?? values[.any]
            }

            public init(_ values: [Layer: AnyShapeStyle]) {
                self.values = values
            }

            public init<Foreground: ShapeStyle, Background: ShapeStyle>(foreground: Foreground? = nil, background: Background? = nil) {
                var values: ShapeStyleForLayer = [:]
                if let foreground {
                    values[.foreground] = AnyShapeStyle(foreground)
                }
                if let background {
                    values[.background] = AnyShapeStyle(background)
                }
                
                self.init(values)
            }

            public static func with(foreground: Color? = nil, background: Color? = nil) -> Self {
                self.init(foreground: foreground, background: background)
            }

        }

    }
    
}
