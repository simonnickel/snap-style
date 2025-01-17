//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

public protocol StyleKey {
    
    associatedtype Value: StyleValue
    
    typealias ValueBuilderKeyPath = KeyPath<Self, Self.ValueBuilder>
    typealias ValueBuilder = SnapStyle.ValueBuilder<SnapStyle.Value<Self>>

    /// Needs an init to access KeyPaths.
    init()
    
}

public protocol StyleValue: CustomStringConvertible {
    
    associatedtype WrappedValue
    
    var wrappedValue: WrappedValue { get }
    
}
