//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension Style.Keys {
    public struct Icon: StyleKey { public init() {} }
}

extension Style.Keys.Icon {


    // MARK: - NumberKey.Value

    public enum Value: StyleValue {

        public typealias WrappedValue = String
        public typealias Adjustment = Style.Keys.Icon.Adjustment

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

        public typealias Value = Style.Keys.Icon.Value

        public func applied(on value: Value) -> Value {
            value
        }

    }

}
