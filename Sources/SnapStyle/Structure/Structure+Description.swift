//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase

extension SnapStyle.Component: CustomStringConvertible {
    
    public var description: String {
        type.rawValue + "." + hierarchy.rawValue
    }
    
}

extension SnapStyle.Element: CustomStringConvertible {
    
    public var description: String {
        type.rawValue + "." + hierarchy.rawValue
    }
    
}
