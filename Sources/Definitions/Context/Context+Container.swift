//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleComponents

// Needs to be located in `Definitions` target to have access to `Component.base`.

extension Style.Context {

    package var containerStack: Style.ContainerStack { getValue(for: Self.containerStack) ?? .init() }
    
    package static var containerStack: Attribute<String, Style.ContainerStack> { .init(key: "containerStack", valueDefault: .init()) }

    public var container: Style.Container {
        let current = containerStack.current ?? .base

        return .init(
            definition: current,
            parent: containerStack.parent,
            state: containerStack.currentState ?? .normal,
            level: containerStack.level
        )
    }

}
