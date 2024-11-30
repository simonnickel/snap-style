//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

protocol StyleKey: CaseIterable, Hashable, RawRepresentable, CustomStringConvertible where RawValue == String {
    
}

extension StyleKey {
    
    public var description: String { rawValue }
    
}
