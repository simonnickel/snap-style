//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase

extension SnapStyle {
    
    package struct ComponentStack: Hashable {


        // MARK: Components

        private var components: [SnapStyle.Component] = []

        var current: Component? { components.last }
        var parent: Component? {
            let parentIndex = components.count - 2
            guard parentIndex >= 0 else { return nil }
            return components[parentIndex]
        }


        // MARK: State

        private var stateByComponent: [SnapStyle.Component : SnapStyle.Component.InteractionState] = [:]

        var currentState: SnapStyle.Component.InteractionState? {
            guard let current else { return nil }
            return stateByComponent[current]
        }


        // MARK: Level

        /// Level of components independent of `Component`.
        var levelOverall: Int {
            components.count - 1
        }

        /// Level of consistent `Component` stacked without interruption.
        var level: Int {
            var result = 1
            var index = components.count - 1
            var continueLoop: Bool = true
            while continueLoop && index > 0 {
                index -= 1
                let parentComponent = components[index]
                if parentComponent == current {
                    result += 1
                } else {
                    continueLoop = false
                }
            }

            return result
        }


        // MARK: Update

        func appended(_ component: SnapStyle.Component, state: SnapStyle.Component.InteractionState) -> Self {
            var result = self
            result.components.append(component)
            result.stateByComponent[component] = state
            return result
        }

    }

}
