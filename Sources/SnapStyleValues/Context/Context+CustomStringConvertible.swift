//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension SnapStyle.Context: CustomStringConvertible {
    
    public var description: String {
        "Component: \(component.description) - Item: \(item.description)"
    }
    
}

extension SnapStyle.Component: CustomStringConvertible {
    
    public var description: String {
        type.rawValue + "." + hierarchy.rawValue
    }
    
}

extension SnapStyle.Item: CustomStringConvertible {
    
    public var description: String {
        type.rawValue + "." + hierarchy.rawValue
    }
    
}
