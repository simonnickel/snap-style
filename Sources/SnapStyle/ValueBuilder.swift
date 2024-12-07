//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension SnapStyle {

    public struct ValueBuilder<Value> {

        let base: Value?

        public typealias Builder = (Context) -> Value?
        let context: Builder?

        public init(_ base: Value, context: Builder? = nil) {
            self.base = base
            self.context = context
        }

        public init(context: @escaping Builder) {
            self.base = nil
            self.context = context
        }

    }

}

