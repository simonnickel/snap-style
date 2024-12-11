//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

public protocol StyleKey {
    
    associatedtype Value: StyleValue
    
    typealias ValueBuilder = SnapStyle.ValueBuilder<Value>
    typealias ValueKeyPath = KeyPath<Self, Self.ValueBuilder>

    /// Needs an init to access KeyPaths.
    init()
        
    static func keyPath(for item: SnapStyle.Item.ItemType) -> ValueKeyPath
    
}
