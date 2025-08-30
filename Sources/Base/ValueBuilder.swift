//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension SnapStyle {

    /// Is an enum instead of a struct to allow cleaner call-site: `.base(value) {} or .builder {}`, instead of `.init(base:) {}`.
    public enum ValueBuilder<Value> {

        public typealias Builder = (Context) -> Value?
        public typealias BuilderPro = (ContextWrapper) -> Value?

        case base(Value?, builder: Builder? = nil)
        case builder(Builder?)
        // TODO: Rename
        case builderPro(BuilderPro?)

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
                    
                case .builderPro(let builder):
                    if let contextWrapper {
                        builder?(contextWrapper)
                    } else {
                        nil
                    }

            }
        }

    }

}
