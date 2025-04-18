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

        public typealias WrappedValue = Color
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

    }
    

    // MARK: - Adjustment

    public enum Adjustment: StyleAdjustment {

        public typealias Value = SnapStyle.ColorKey.Value

        case opacity(Double)

        public func applied(on value: Value.WrappedValue) -> Value.WrappedValue {
            switch self {
                case .opacity(let opacity): value.opacity(opacity)
            }
        }
    }

}
