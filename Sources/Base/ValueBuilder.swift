//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension SnapStyle {

    /// Is an enum instead of a struct to allow cleaner call-site: `.base(value) {} or .builder {}`, instead of `.init(base:) {}`.
    public enum ValueBuilder<Value> {

        // TODO: Could consider to provide ContextWrapper instead of just Context. Would allow to resolve values, e.g. to create a Gradient from other definitions.
        public typealias Builder = (Context) -> Value?

        case base(Value?, builder: Builder? = nil)
        case builder(Builder?)

        func value(in context: Context?) -> Value? {
            return switch self {

                case .base(let value, let builder):
                    if let context {
                        builder?(context) ?? value
                    } else {
                        value
                    }

                case .builder(let builder):
                    if let context {
                        builder?(context)
                    } else {
                        nil
                    }

            }
        }

    }

}
