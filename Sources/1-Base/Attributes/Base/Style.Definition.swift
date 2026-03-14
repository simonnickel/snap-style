//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension Style {

    /// Type produced by a `ValueBuilder` that represents either a direct value or a reference to another key path.
    public enum Definition<Attribute: StyleAttribute> {

        /// A reference to another `KeyPath`, with a set of adjustments.
        case reference(Attribute.ValueBuilderKeyPath, adjustments: [Attribute.Value.Adjustment] = [])

        /// A definition of an actual value.
        case value(Attribute.Value)

    }

}
