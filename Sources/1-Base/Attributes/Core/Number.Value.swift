//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension Style.Attribute {
    public struct Number: StyleAttribute { public init() {} }
}

extension Style.Attribute.Number {


    // MARK: - Value

    public enum Value: StyleValue {

        public typealias WrappedValue = Double
        public typealias Adjustment = Style.Attribute.Number.Adjustment

        case scaled(WrappedValue)

        public var wrappedValue: WrappedValue {
            switch self {
                case .scaled(let value): value
            }
        }

        public var description: String {
            switch self {
                case .scaled(let value): ".value: \(value)"
            }
        }

    }


    // MARK: - Adjustment

    public enum Adjustment: StyleAdjustment {

        public typealias Value = Style.Attribute.Number.Value

        public func applied(on value: Value) -> Value {
            value
        }

    }

}
