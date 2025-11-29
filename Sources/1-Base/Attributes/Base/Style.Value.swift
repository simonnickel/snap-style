//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension Style {

    /// Top level type of value wrapper created by a `ValueBuilder`. It wraps the actual value to allow generic handling of references.
    public enum Value<Attribute: StyleAttribute> {

        /// A reference to another `KeyPath`, with a set of adjustments.
        case reference(Attribute.ValueBuilderKeyPath, adjustments: [Attribute.Value.Adjustment] = [])

        /// A definition of an actual value.
        case definition(Attribute.Value)

    }

}
