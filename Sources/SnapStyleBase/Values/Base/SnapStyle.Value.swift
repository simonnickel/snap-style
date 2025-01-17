//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension SnapStyle {
    
    public enum Value<Key: StyleKey> {
        case reference(Key.ValueKeyPath)
        case definition(Key.Value)
    }
    
}
