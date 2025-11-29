//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension Style.Attributes {
    public struct Icon: StyleAttribute { public init() {} }
}

extension Style.Attributes.Icon {


    // MARK: - Value

    public enum Value: StyleValue {

        public typealias WrappedValue = String
        public typealias Adjustment = Style.Attributes.Icon.Adjustment

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

        public typealias Value = Style.Attributes.Icon.Value

        public func applied(on value: Value) -> Value {
            value
        }

    }

}
