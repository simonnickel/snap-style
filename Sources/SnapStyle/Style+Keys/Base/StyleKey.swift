//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

protocol StyleKey {
    
    associatedtype Value
    associatedtype ValueKeyPath: KeyPath<Self, SnapStyle.ValueBuilder<Value>>

    init()
    
    static func keyPath(for item: SnapStyle.Item.ItemType) -> ValueKeyPath
    
    static func isErase(_ value: Value) -> Bool
    
}
