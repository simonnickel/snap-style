//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

/// A `StyleAttribute` defines a dimension of styling applied to a View and is used as a generic constraint of a `Value`.
/// It defines an associated `Value` type and provides types for a `ValueBuilder` to create values of the attribute.
public protocol StyleAttribute {

    associatedtype Value: StyleValue
    associatedtype Adjustment: StyleAdjustment where Value.WrappedValue == Adjustment.Value.WrappedValue

    typealias ValueBuilderKeyPath = KeyPath<Self, Self.ValueBuilder>
    typealias ValueBuilder = Style.ValueBuilder<Style.Definition<Self>>

    /// Needs an init to access KeyPaths.
    init()

}


// MARK: - StyleValue

public protocol StyleValue: CustomStringConvertible {

    /// The underlying type that this `StyleValue` wraps.
    /// NOTE: WrappedValue could map to `Self` if forwarding initializers is inconvenient. In most cases it's convenient to have a separate type though.
    associatedtype WrappedValue
    associatedtype Adjustment: StyleAdjustment where Self == Adjustment.Value

    var wrappedValue: WrappedValue { get }

}


// MARK: - Adjustment

public protocol StyleAdjustment {

    associatedtype Value: StyleValue

    func applied(on value: Value) -> Value

}

extension StyleValue {

    public func adjusted(with adjustments: [Self.Adjustment]) -> Self {
        var result = self
        for adjustment in adjustments {
            result = result.adjusted(with: adjustment)
        }
        return result
    }

    func adjusted(with adjustment: Adjustment) -> Self {
        adjustment.applied(on: self)
    }

}
