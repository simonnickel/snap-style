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

        public static func create(with value: WrappedValue) -> Self {
            .any(value)
        }

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

        public func applied(on value: Value.WrappedValue) -> Value.WrappedValue {
            switch self {
                case .opacity(let opacity): AnyShapeStyle(value.opacity(opacity))
            }
        }
    }

}
