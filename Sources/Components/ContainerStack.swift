//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase

extension Style {

    package struct ContainerStack: Hashable {

        package init() {}


        // MARK: Containers

        private var items: [Style.ContainerDefinition] = []

        package var current: ContainerDefinition? { items.last }
        package var parent: ContainerDefinition? {
            let parentIndex = items.count - 2
            guard parentIndex >= 0 else { return nil }
            return items[parentIndex]
        }


        // MARK: State

        private var stateByItem: [Style.ContainerDefinition: Style.Container.InteractionState] = [:]

        package var currentState: Style.Container.InteractionState? {
            guard let current else { return nil }
            return stateByItem[current]
        }


        // MARK: Level

        /// Level of components independent of `Component`.
        package var levelOverall: Int {
            items.count - 1
        }

        /// Level of consistent `Component` stacked without interruption.
        package var level: Int {
            var result = 1
            var index = items.count - 1
            var continueLoop: Bool = true
            while continueLoop && index > 0 {
                index -= 1
                let parentComponent = items[index]
                if parentComponent == current {
                    result += 1
                } else {
                    continueLoop = false
                }
            }

            return result
        }


        // MARK: Update

        package func appended(_ container: Style.ContainerDefinition, state: Style.Container.InteractionState) -> Self {
            var result = self
            result.items.append(container)
            result.stateByItem[container] = state
            return result
        }

    }

}
