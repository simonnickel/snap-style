//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase

extension SnapStyle {

    package struct ComponentStack: Hashable {

        package init() {}


        // MARK: Components

        private var components: [SnapStyle.ComponentDefinition] = []

        package var current: ComponentDefinition? { components.last }
        package var parent: ComponentDefinition? {
            let parentIndex = components.count - 2
            guard parentIndex >= 0 else { return nil }
            return components[parentIndex]
        }


        // MARK: State

        private var stateByComponent: [SnapStyle.ComponentDefinition: SnapStyle.Component.InteractionState] = [:]

        package var currentState: SnapStyle.Component.InteractionState? {
            guard let current else { return nil }
            return stateByComponent[current]
        }


        // MARK: Level

        /// Level of components independent of `Component`.
        package var levelOverall: Int {
            components.count - 1
        }

        /// Level of consistent `Component` stacked without interruption.
        package var level: Int {
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

        package func appended(_ component: SnapStyle.ComponentDefinition, state: SnapStyle.Component.InteractionState) -> Self {
            var result = self
            result.components.append(component)
            result.stateByComponent[component] = state
            return result
        }

    }

}
