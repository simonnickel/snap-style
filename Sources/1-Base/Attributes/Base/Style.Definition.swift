//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension Style {

    /// Top level type to wrap values created by a `ValueBuilder`. It wraps the actual value to allow generic handling of references.
    public enum Definition<Attribute: StyleAttribute> {

        /// A reference to another `KeyPath`, with a set of adjustments.
        case reference(Attribute.ValueBuilderKeyPath, adjustments: [Attribute.Value.Adjustment] = [])

        /// A definition of an actual value.
        case value(Attribute.Value)

    }

}
