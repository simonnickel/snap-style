//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension SnapStyle {
    public struct AccentKey: StyleKey { public init() {} }
}

extension SnapStyle.AccentKey {


    // MARK: - NumberKey.Value

    public enum Value: StyleValue {

        // TODO: Should SnapStyle.Accent move to be just the value here?
        public typealias WrappedValue = SnapStyle.Accent
        public typealias Adjustment = SnapStyle.AccentKey.Adjustment

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

        public typealias Value = SnapStyle.AccentKey.Value

        public func applied(on value: Value) -> Value {
            value
        }

    }

}
