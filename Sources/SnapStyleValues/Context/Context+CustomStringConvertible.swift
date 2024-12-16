//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension SnapStyle.Context: CustomStringConvertible {
    
    public var description: String {
        "Component: \(component.description) - Element: \(element.description)"
    }
    
}

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
