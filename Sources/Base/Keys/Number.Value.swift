//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension Style.Attributes {
    public struct Number: StyleAttribute { public init() {} }
}

extension Style.Attributes.Number {


    // MARK: - Value

    public enum Value: StyleValue {

        public typealias WrappedValue = Double
        public typealias Adjustment = Style.Attributes.Number.Adjustment

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

        public typealias Value = Style.Attributes.Number.Value

        public func applied(on value: Value) -> Value {
            value
        }

    }

}
