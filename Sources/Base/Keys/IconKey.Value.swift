//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension Style {
    public struct IconKey: StyleKey { public init() {} }
}

extension Style.IconKey {


    // MARK: - NumberKey.Value

    public enum Value: StyleValue {

        public typealias WrappedValue = String
        public typealias Adjustment = Style.IconKey.Adjustment

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

        public typealias Value = Style.IconKey.Value

        public func applied(on value: Value) -> Value {
            value
        }

    }

}
