//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension SnapStyle {

    /// Is an enum instead of a struct to allow cleaner call-site: `.base(value) {} or .builder {}`, instead of `.init(base:) {}`.
    public enum ValueBuilder<Value> {

        public typealias Builder = (Context) -> Value?
        public typealias BuilderWithCaches = (ContextWrapper) -> Value?

        case base(Value?, builder: Builder? = nil)
        case builder(Builder?)
        case builderWithCaches(BuilderWithCaches?)

        func value(in wrapper: ContextWrapper?) -> Value? {
            return switch self {

                case .base(let value, let builder):
                    if let wrapper {
                        builder?(wrapper.context) ?? value
                    } else {
                        value
                    }

                case .builder(let builder):
                    if let wrapper {
                        builder?(wrapper.context)
                    } else {
                        nil
                    }

                case .builderWithCaches(let builder):
                    if let wrapper {
                        builder?(wrapper)
                    } else {
                        nil
                    }

            }
        }

    }

}
