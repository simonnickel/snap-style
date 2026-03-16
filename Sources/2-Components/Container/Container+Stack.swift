//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase

extension Style.Container {

    package struct Stack: Hashable {

        package init() {}


        // MARK: Containers

        private var items: [Properties] = []

        package var current: Properties? { items.last }
        
        package var parent: Properties? {
            let parentIndex = items.count - 2
            guard parentIndex >= 0 else { return nil }
            return items[parentIndex]
        }


        // MARK: State

        private var stateByItem: [Properties: InteractionState] = [:]

        package var currentState: InteractionState? {
            guard let current else { return nil }
            return stateByItem[current]
        }


        // MARK: Level

        /// Level of containers independent of their identity.
        /// If empty it is -1.
        package var levelOverall: Int {
            items.count - 1
        }

        /// Level of consistent `Properties` stacked without interruption.
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

        package func appended(_ container: Properties, state: InteractionState) -> Self {
            var result = self
            result.items.append(container)
            result.stateByItem[container] = state
            return result
        }

    }

}
