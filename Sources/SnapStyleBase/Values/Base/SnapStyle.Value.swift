//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension SnapStyle {
    
    public enum Value<Key: StyleKey> {
        case reference(Key.ValueBuilderKeyPath)
        case definition(Key.Value)
    }
    
}
