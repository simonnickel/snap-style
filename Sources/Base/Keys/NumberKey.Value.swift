//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension Style {
    public struct NumberKey: StyleKey { public init() {} }
}

extension Style.NumberKey {


    // MARK: - NumberKey.Value

    public enum Value: StyleValue {

        public typealias WrappedValue = Double
        public typealias Adjustment = Style.NumberKey.Adjustment

        case value(WrappedValue)

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

        public typealias Value = Style.NumberKey.Value

        public func applied(on value: Value) -> Value {
            value
        }

    }

}
