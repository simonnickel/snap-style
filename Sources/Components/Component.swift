//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase

extension Style {

    /// An actual `Component` instance for a specific View.
    public struct Component {

        package let definition: ComponentDefinition
        package let parent: ComponentDefinition?
        package let state: InteractionState
        package let level: Int

        package init(
            definition: ComponentDefinition,
            parent: ComponentDefinition?,
            state: InteractionState,
            level: Int
        ) {
            self.definition = definition
            self.parent = parent
            self.state = state
            self.level = level
        }

        public var useSecondaryAccent: Bool { parent?.requiresSecondaryAccent ?? false }


        // MARK: - InteractionState

        public enum InteractionState: Comparable {
            case disabled
            case inactive
            case normal
            case highlighted
            case selected

            private var priority: Int {
                switch self {
                    case .disabled: 0
                    case .inactive: 1
                    case .selected: 2
                    case .highlighted: 3
                    case .normal: 4
                }
            }

            public static func <(lhs: InteractionState, rhs: InteractionState) -> Bool {
                lhs.priority > rhs.priority
            }
        }

    }

}
