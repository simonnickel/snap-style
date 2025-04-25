//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension SnapStyle {
    public struct ColorKey: StyleKey { public init() {} }
}

extension SnapStyle.ColorKey {


    // MARK: - ColorKey.Value

    public enum Value: StyleValue {

        public typealias WrappedValue = SnapShapeStyle
        public typealias Adjustment = SnapStyle.ColorKey.Adjustment

        case value(WrappedValue)

        public static func create(with value: WrappedValue) -> Self {
            .value(value)
        }

        public var wrappedValue: WrappedValue {
            switch self {
                case .value(let value): value
            }
        }
        
        public var description: String {
            switch self {
                case .value(let value): ".value: \(value)"
            }
        }
        
        public enum SnapShapeStyle: ShapeStyle {
            case color(Color)
            case gradient(Gradient)
            
            public func resolve(in environment: EnvironmentValues) -> AnyShapeStyle {
                switch self {
                    case .color(let color): AnyShapeStyle(color)
                    case .gradient(let gradient): AnyShapeStyle(gradient)
                }
            }
        }

    }
    

    // MARK: - Adjustment

    public enum Adjustment: StyleAdjustment {

        public typealias Value = SnapStyle.ColorKey.Value

        case opacity(Double)

        public func applied(on value: Value.WrappedValue) -> Value.WrappedValue {
            switch value {
                case .color(let color):
                    switch self {
                        case .opacity(let opacity): .color(color.opacity(opacity))
                    }
                    
                case .gradient(let gradient):
                    // TODO: Add Adjustments
                    .gradient(gradient)
            }
        }
    }

}
