//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

public protocol StyleKey {
    
    associatedtype Value
    associatedtype ValueKeyPath: KeyPath<Self, SnapStyle.ValueBuilder<Value>>

    /// Needs an init to access KeyPaths.
    init()
    
    static func keyPath(for item: SnapStyle.Item.ItemType) -> ValueKeyPath
    
    static func isErase(_ value: Value) -> Bool
    
}
