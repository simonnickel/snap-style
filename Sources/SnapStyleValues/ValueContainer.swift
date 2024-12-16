//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension SnapStyle {

    public struct ValueContainer<Value> {
        public var valuesForContext: [SnapStyle.Context: Value]

        func value(for context: SnapStyle.Context) -> Value? {
            valuesForContext[context] ?? valuesForContext[.any]
        }

        mutating func override(with overrides: [SnapStyle.Context: Value]) {
            for (context, value) in overrides {
                valuesForContext[context] = value
            }
        }

        mutating func erase(_ contexts: [SnapStyle.Context]) {
            for context in contexts {
                valuesForContext.removeValue(forKey: context)
            }
        }
    }

}
