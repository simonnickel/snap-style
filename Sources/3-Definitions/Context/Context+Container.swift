//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleComponents

// Needs to be located in `Definitions` target to have access to `.base`.

extension Style.Context {

    package var containerStack: Style.Container.Stack { getValue(for: Self.containerStack) ?? .init() }
    
    package static var containerStack: Attribute<String, Style.Container.Stack> { .init(key: "containerStack", valueDefault: .init()) }

    public var container: Style.Container {
        let current = containerStack.current ?? .base

        return .init(
            properties: current,
            parent: containerStack.parent,
            state: containerStack.currentState ?? .normal,
            level: containerStack.level
        )
    }

}
