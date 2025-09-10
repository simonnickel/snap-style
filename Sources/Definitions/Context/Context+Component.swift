//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleComponents

// Needs to be located in `Definitions` target to have access to `Component.base`.

extension Style.Context {

    package var componentStack: Style.ComponentStack { getValue(for: Self.componentStack) ?? .init() }
    
    package static var componentStack: Attribute<String, Style.ComponentStack> { .init(key: "componentStack", valueDefault: .init()) }

    public var component: Style.Component {
        let current = componentStack.current ?? .base

        return .init(
            definition: current,
            parent: componentStack.parent,
            state: componentStack.currentState ?? .normal,
            level: componentStack.level
        )
    }

}
