//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension SnapStyle {
    
    /// Top level type of value wrapper created by a `ValueBuilder`. It wraps the actual value to allow generic handling of references.
    public enum Value<Key: StyleKey> {
        
        /// A reference to another `KeyPath`.
        case reference(Key.ValueBuilderKeyPath)
        
        /// A definition of an actual value.
        case definition(Key.Value)
        
    }
    
}
