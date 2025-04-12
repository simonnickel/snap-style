//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

public protocol StyleKey {
    
    associatedtype Value: StyleValue
    associatedtype Adjustment: StyleAdjustment where Value.WrappedValue == Adjustment.Value.WrappedValue

    typealias ValueBuilderKeyPath = KeyPath<Self, Self.ValueBuilder>
    typealias ValueBuilder = SnapStyle.ValueBuilder<SnapStyle.Value<Self>>

    /// Needs an init to access KeyPaths.
    init()

}


// MARK: - StyleValue

public protocol StyleValue: CustomStringConvertible {

    associatedtype WrappedValue
    associatedtype Adjustment: StyleAdjustment where WrappedValue == Adjustment.Value.WrappedValue

    func create(with: WrappedValue) -> Self
    var wrappedValue: WrappedValue { get }

    func value(with adjustments: [Self.Adjustment]) -> Self

}


// MARK: - Adjustment

public protocol StyleAdjustment {

    associatedtype Value: StyleValue

    func applied(on value: Value.WrappedValue) -> Value.WrappedValue

}

extension StyleValue {

    public func value(with adjustments: [Self.Adjustment]) -> Self {
        var result = wrappedValue
        for adjustment in adjustments {
            result = adjustment.applied(on: result)
        }
        return create(with: result)
    }

}
