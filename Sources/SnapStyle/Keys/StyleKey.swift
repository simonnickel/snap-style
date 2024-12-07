//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

protocol StyleKey: CaseIterable, Hashable, RawRepresentable, CustomStringConvertible where RawValue == String {

    static func key(for item: SnapStyle.Item.ItemType) -> Self
}

extension StyleKey {
    
    public var description: String { rawValue }
    
}
