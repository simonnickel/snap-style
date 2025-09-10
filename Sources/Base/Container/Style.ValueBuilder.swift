//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension Style {

    /// Is an enum instead of a struct to allow cleaner call-site: `.base(value) {} or .builder {}`, instead of `.init(base:) {}`.
    public enum ValueBuilder<Value> {

        public typealias Builder = (Context) -> Value?
        public typealias BuilderWrapper = (ContextWrapper) -> Value?

        case base(Value?, builder: Builder? = nil)
        case builder(Builder?)
        case builderWrapper(BuilderWrapper?)

        func value(in contextWrapper: ContextWrapper?) -> Value? {
            return switch self {

                case .base(let value, let builder):
                    if let context = contextWrapper?.context {
                        builder?(context) ?? value
                    } else {
                        value
                    }

                case .builder(let builder):
                    if let context = contextWrapper?.context {
                        builder?(context)
                    } else {
                        nil
                    }
                    
                case .builderWrapper(let builder):
                    if let contextWrapper {
                        builder?(contextWrapper)
                    } else {
                        nil
                    }

            }
        }

    }

}
