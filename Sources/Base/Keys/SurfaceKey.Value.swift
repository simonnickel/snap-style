//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension Style {
    public struct SurfaceKey: StyleKey { public init() {} }
}

extension Style.SurfaceKey {


    // MARK: - SurfaceKey.Value

    public enum Value: StyleValue {

        /// Does not define a type for WrappedValue for easier access.
        public typealias WrappedValue = Self
        public typealias Adjustment = Style.SurfaceKey.Adjustment

        case color(Color)
        case material(Material)
        case any(AnyShapeStyle)

        public var wrappedValue: WrappedValue {
            self
        }
        
        public var resolvedColor: Color? {
            switch self {
                case .color(let color): color
                default : nil
            }
        }
        
        public var anyShapeStyle: AnyShapeStyle? {
            switch self {
                case .color(let color): AnyShapeStyle(color)
                case .material(let material): AnyShapeStyle(material)
                case .any(let anyShapeStyle): AnyShapeStyle(anyShapeStyle)
            }
        }

        public var description: String {
            switch self {
                case .color(let value): ".color: \(value)"
                case .material(let value): ".material: \(value)"
                case .any(let value): ".any: \(value)"
            }
        }

    }


    // MARK: - Adjustment

    public enum Adjustment: StyleAdjustment {

        public typealias Value = Style.SurfaceKey.Value

        case opacity(Double)
        case mix(Color, Double)

        public func applied(on value: Value) -> Value {
            switch value {
                case .color(let color):
                    switch self {
                        case .opacity(let opacity): .color(color.opacity(opacity))
                        case .mix(let mix, let amount): .color(color.mix(with: mix, by: amount))
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
