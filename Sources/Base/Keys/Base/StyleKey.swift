//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

public protocol StyleKey {

    associatedtype Value: StyleValue
    associatedtype Adjustment: StyleAdjustment where Value.WrappedValue == Adjustment.Value.WrappedValue

    typealias ValueBuilderKeyPath = KeyPath<Self, Self.ValueBuilder>
    typealias ValueBuilder = Style.ValueBuilder<Style.Value<Self>>

    /// Needs an init to access KeyPaths.
    init()

}


// MARK: - StyleValue

public protocol StyleValue: CustomStringConvertible {

    /// A Type to separate the Definition from the Value.
    /// NOTE: WrappedValue could map to `Self`if forwarding initializers is inconvenient. In most cases its convenient to have a separate type though.
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
