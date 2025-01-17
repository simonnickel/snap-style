//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

public protocol StyleKey {
    
    associatedtype Value: StyleValue
    
    typealias ValueKeyPath = KeyPath<Self, Self.ValueBuilder>
    typealias ValueBuilder = SnapStyle.ValueBuilder<SnapStyle.Value<Self>>

    /// Needs an init to access KeyPaths.
    init()
    
}
