//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension Style.Attribute {
    public struct Icon: StyleAttribute { public init() {} }
}

extension Style.Attribute.Icon {


    // MARK: - Value

    public enum Value: StyleValue {

        public typealias WrappedValue = String
        public typealias Adjustment = Style.Attribute.Icon.Adjustment

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

        public typealias Value = Style.Attribute.Icon.Value

        public func applied(on value: Value) -> Value {
            value
        }

    }

}
