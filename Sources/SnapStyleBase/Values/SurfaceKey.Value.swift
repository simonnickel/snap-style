//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension SnapStyle {
    public struct SurfaceKey: StyleKey { public init() {} }
}

extension SnapStyle.SurfaceKey {


    // MARK: - SurfaceKey.Value

    public enum Value: StyleValue {

        public typealias WrappedValue = AnyShapeStyle
        public typealias Adjustment = SnapStyle.SurfaceKey.Adjustment

        case color(Color)
        case gradient(AnyShapeStyle)
        case material(Material)
        case any(AnyShapeStyle)
        
        public var wrappedValue: WrappedValue {
            switch self {
                case .color(let value): AnyShapeStyle(value)
                case .gradient(let value): value
                case .material(let value): AnyShapeStyle(value)
                case .any(let value): value
            }
        }
        
        public var description: String {
            switch self {
                case .color(let value): ".color: \(value)"
                case .gradient(let value): ".gradient: \(value)"
                case .material(let value): ".material: \(value)"
                case .any(let value): ".any: \(value)"
            }
        }

    }
    

    // MARK: - Adjustment

    public enum Adjustment: StyleAdjustment {

        public typealias Value = SnapStyle.SurfaceKey.Value

        case opacity(Double)
        case mix(Color, Double)
        
        public func applied(on value: Value) -> Value {
            switch value {
                case .color(let color):
                    switch self {
                        case .opacity(let opacity): .color(color.opacity(opacity))
                        case .mix(let mix, let amount): .color(color.mix(with: mix, by: amount))
                    }
                    
                case .gradient(let gradient):
                    switch self {
                        case .opacity(let opacity): .gradient(AnyShapeStyle(gradient.opacity(opacity)))
                        default: .gradient(gradient)
                    }
                    
                    // Material gets converted to some ShapeStyle and can no longer be applied as .material
                    // case .material(let material):
                    //     switch adjustment {
                    //         case .opacity(let opacity): .material(material.opacity(opacity))
                    //         default: .material(material)
                    //     }
                    
                case .any(let any):
                    switch self {
                        case .opacity(let opacity): .any(AnyShapeStyle(any.opacity(opacity)))
                        default: .any(any)
                    }
                    
                default: value
            }
        }

    }

}
