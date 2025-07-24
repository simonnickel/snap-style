//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension SnapStyle {

    /// Top level type of value wrapper created by a `ValueBuilder`. It wraps the actual value to allow generic handling of references.
    public enum Value<Key: StyleKey> {

        /// A reference to another `KeyPath`, with a set of adjustments.
        case reference(Key.ValueBuilderKeyPath, adjustments: [Key.Value.Adjustment] = [])

        /// A definition of an actual value.
        case definition(Key.Value)
        
        // TODO: Should have a different name to not confuse it with the actual ValueBuilder
        // TODO: Could the action ValueBuilder get ContextWrapper instead of just the Context? Would make this redundant.
//        case builder((SnapStyle.ContextWrapper) -> Key.Value)

    }

}
