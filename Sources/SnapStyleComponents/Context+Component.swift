//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase

extension SnapStyle.Context {

    package var componentStack: SnapStyle.ComponentStack { getValue(for: Self.componentStack) ?? .init() }
    package static var componentStack: Attribute<String, SnapStyle.ComponentStack> { .init(key: "componentStack", valueDefault: .init()) }

    public var component: SnapStyle.Component {
        let current = componentStack.current ?? .init("") // TODO: Was .base, but its not accessible in this target. Is it necessary?

        return .init(
            definition: current,
            parent: componentStack.parent,
            state: componentStack.currentState ?? .normal,
            level: componentStack.level
        )
    }

}
