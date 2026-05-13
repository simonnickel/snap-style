//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase

extension Style {

    /// Describes how a value should be applied when adjusting an existing style.
    ///
    /// - `.keep` to use the receiver's value (default)
    /// - `.set(value)` to override
    /// - `.clear` is available as sugar for `.set(nil)` for optional `Value`.
    /// When `Value` is a `ValueBuilderKeyPathProvider?`, `.set(\.keyPath)` accepts a `ValueBuilderKeyPath` via autoclosure.
    public enum Override<Value: Sendable>: Sendable {

        /// Use the source's existing value.
        case keep

        /// Override with the provided value.
        case set(Value)

        /// Resolves the override against the source's existing value.
        public func resolved(against base: Value) -> Value {
            switch self {
                case .keep: base
                case .set(let value): value
            }
        }

    }

}


// MARK: - Convenience

extension Style.Override where Value: ExpressibleByNilLiteral {

    /// Explicitly remove any value, even if the source provided one. Convenience shortcut for `.set(nil)`.
    public static var clear: Self { .set(nil) }

}

extension Style.Override {

    /// Override with the provided `ValueBuilderKeyPath`. Wraps the autoclosure into a `ValueBuilderKeyPathProvider`.
    public static func set<Attribute: StyleAttribute>(
        _ keyPath: @autoclosure @escaping @Sendable () -> Attribute.ValueBuilderKeyPath?
    ) -> Self where Value == Attribute.ValueBuilderKeyPathProvider? {
        .set(keyPath)
    }

}
