//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

protocol StyleKey: CaseIterable, Hashable, RawRepresentable, CustomStringConvertible where RawValue == String {
    
    associatedtype Value

    static func key(for item: SnapStyle.Item.ItemType) -> Self
    
    static func isErase(_ value: Value) -> Bool
    
}

extension StyleKey {
    
    public var description: String { rawValue }
    
}
